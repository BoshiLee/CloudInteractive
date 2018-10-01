//
//  BaseViewModel.swift
//  testReach
//
//  Created by Boshi Li on 22/03/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

final class BaseViewModel {
    
    lazy var reachability = Reachability()!
    
    weak var presenter: BasePresentable?
    
    func addReachabilityObsever() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func stopReachabilityObesever() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .cellular, .wifi:
            self.presenter?.didUIStateChanged(UIState.initial)
        case .none:
            self.presenter?.didUIStateChanged(UIState.error(NetworkingError.noNetworkingConnect, nil))
        }
    }
}
