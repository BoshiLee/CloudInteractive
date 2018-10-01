//
//  JSONManager.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/5.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

typealias ResultCompletionHandler<T: Codable> = (ResponseState<T>)->()
typealias responseContent = (data: Data?, response:  URLResponse?, requestURL: URL, error: Error?)

protocol RequestManager {
    var session: URLSessionProtocol { get }
    ///For D.I.
    init(session: URLSessionProtocol)
}

extension RequestManager {
    
    func generateTask<T: Codable>(with apiInformation: APIEndPointProtocol, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let request = HTTPService.generateRequest(with: apiInformation)
        let task = session.dataTask(with: request) { (data, response, url, error) in
            self.handleResponse(with: (data, response, url, error), model: model, completionHandler: completionHandler)
        }
        return task
    }
    ///Response check
    func handleResponse<T: Codable>(with responseContent: responseContent, model: T.Type, completionHandler: ResultCompletionHandler<T>) {
        
        guard responseContent.error == nil else {
            let nsError = (responseContent.error)! as NSError
            //無網路
            //NSURLErrorCannotLoadFromNetwork -2000
            //NSURLErrorNetworkConnectionLost -1015
            //NSURLErrorCallIsActive -1019
            //NSURLErrorNotConnectedToInternet -1009
            switch nsError.code {
            case -1009, -2000, -1005, -1019: completionHandler(ResponseState.failure(NetworkingError.noNetworkingConnect))
            default: completionHandler(ResponseState.failure(NetworkingError.error(responseContent.error!)))
            }
            return
        }
        guard let response = responseContent.response, let data = responseContent.data else {
            completionHandler(ResponseState.failure(NetworkingError.responseAndDataNil))
            return
        }
        guard responseContent.requestURL == response.url else {
            completionHandler(ResponseState.failure(NetworkingError.urlDismatch))
            return
        }
        // MARK: - For Bump
        guard 200...299 ~= (response as! HTTPURLResponse).statusCode else {
            guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) else{
                completionHandler(ResponseState.failure(NetworkingError.errorMessageJSONParseFail))
                return
            }
            completionHandler(ResponseState.failure(NetworkingError.requestError(errorModel)))
            return
        }
        
        //success part
        guard let dataModel = try? JSONDecoder().decode(T.self, from: data) else{
            completionHandler(ResponseState.failure(NetworkingError.jsonParseFail))
            return
        }
        completionHandler(ResponseState.success(dataModel))
    }
    func handleDataResponse(with responseContent: responseContent) -> Data? {
        guard responseContent.error == nil else { return nil }
        guard let response = responseContent.response, let data = responseContent.data else { return nil }
        guard responseContent.requestURL == response.url else { return nil }
        guard 200...299 ~= (response as! HTTPURLResponse).statusCode else { return nil }
        return data
    }
}
