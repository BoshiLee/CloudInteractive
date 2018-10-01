//
//  SocketIOClientHelper.swift
//  Bump
//
//  Created by Boshi Li on 13/07/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

//import SocketIO
//
//extension SocketIOClient {
//    convenience init?(socket: Socket) {
//        guard let url = socket.url else {
//            InternetError.abort("initial socket failed, plesase check correct url!").handler()
//            return nil
//        }
//        self.init(socketURL: url, config: [.log(true), .forcePolling(true)])
//    }
//}
//
//
//enum Socket {
//
//    case groupChatroom // Use for group
//
//    var url: URL? {
//        get {
//            switch self {
//            case .groupChatroom:
//                guard let chatURL = URL(string: APIRouter.chatroom.routing()) else {
//                    InternetError.abort("initial socket failed, plesase check correct url!").handler()
//                    return nil
//                }
//                return chatURL
//            }
//        }
//    }
//
//    func creatSocket() -> SocketIOClient? {
//        switch self {
//        case .groupChatroom:
//            guard let socket = SocketIOClient(socket: self) else { return nil }
//            return socket
//        }
//    }
//}

