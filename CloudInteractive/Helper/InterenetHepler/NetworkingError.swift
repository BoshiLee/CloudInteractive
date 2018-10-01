//
//  InternetErrors.swift
//  Bump
//
//  Created by Boshi Li on 11/05/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import Foundation

///Networking Error
enum NetworkingError {
    
    case responseAndDataNil
    case urlDismatch
    case errorMessageJSONParseFail
    case jsonParseFail
    case error(Error)
    case noNetworkingConnect
    case requestError(ErrorModel)
    case othersError(String)
    
    var rawValue : String {
        switch self {
        case .responseAndDataNil: return "ERROR: Response or Data is nil"
        case .urlDismatch: return "ERROR: RequestURL and ResponseURL dismatch"
        case .errorMessageJSONParseFail: return "ERROR: Error Message JSON parse fail"
        case .jsonParseFail: return "ERROR: JSON parse fail"
        case .error(let error): return "ERROR: \(error.localizedDescription)"
        case .noNetworkingConnect: return "ERROR: No Networking connect."
        case .othersError(let message): return "ERROR: \(message)"
        case .requestError(let errorModel): return "ERROR: \(errorModel.errorDescription)"
        }
    }
}

