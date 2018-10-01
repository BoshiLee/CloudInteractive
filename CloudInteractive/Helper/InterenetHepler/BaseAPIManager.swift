//
//  BaseAPIManager.swift
//  Bump
//
//  Created by JerryWang on 2018/3/4.
//  Copyright © 2018年 Boshi Li. All rights reserved.
//

import Foundation

// MARK: - Handle url, parameters, header, method
enum MemberAPI {
    
    ///BaseURL Endpoint(parameter, header)
    case signUp(key1: String, key2: String, header: String)
    case signIn(key1: String, key2: String, header: String)
    case signOut(key1: String, key2: String, header: String)
    
    ///Combinate all urls with their own endpoint.
    fileprivate var urlString : String {
        var endPoint = ""
        switch self {
        case .signUp: endPoint = "/signUp"
        case .signIn: endPoint = "/signIn"
        case .signOut: endPoint = "signOut"
        }
        return "https://memberBaseURL.com" + endPoint
    }
    
    fileprivate func fetchSignUpParameters() -> RequestModel {
        guard case let .signUp (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["signUpAccount": key1, "signUpPassword": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
    fileprivate func fetchSignInParameters() -> RequestModel {
        guard case let .signIn (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["signInAccount": key1, "signInPassword": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
    fileprivate func fetchSignOutParameters() -> RequestModel {
        guard case let .signOut (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["signOutAccount": key1, "signOutPassword": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
}

extension MemberAPI: APIEndPointProtocol {
    func provideValues() -> APIRequestValues {
        var apiRequestValues: APIRequestValues
        switch self {
        case .signUp:
            apiRequestValues = APIRequestValues(url: urlString, encodeType: .inBody(.POST, .urlencoded), requestModel: fetchSignUpParameters())
        case .signIn:
            apiRequestValues = APIRequestValues(url: urlString, encodeType: .inBody(.POST, .urlencoded), requestModel: fetchSignUpParameters())
        case .signOut:
            apiRequestValues = APIRequestValues(url: urlString, encodeType: .inBody(.POST, .urlencoded), requestModel: fetchSignUpParameters())
        }
        return apiRequestValues
        
    }
}

// MARK: - Public method for MemberAPIBaseURL
struct MemberAPIService: RequestManager {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func signUp<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let request = HTTPService.generateRequest(with: MemberAPI.signUp(key1: key1, key2: key2, header: header))
        let task = session.dataTask(with: request) { (data, response, url, error) in
            self.handleResponse(with: (data, response, url, error), model: model, completionHandler: completionHandler)
            guard let httpURLResponse = response as? HTTPURLResponse else { return }
            guard let token = httpURLResponse.allHeaderFields["x-access-token"] as? String else { return }
            UserDefaultsHelper.userAccessToken.set(token)
        }
        return task
    }
    
    func signIn<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = MemberAPI.signIn(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
    
    func signOut<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = MemberAPI.signOut(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
}

