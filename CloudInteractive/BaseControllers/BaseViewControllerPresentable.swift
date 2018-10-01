//
//  BaseViewControllerPresentable.swift
//  Gameplex
//
//  Created by Boshi Li on 2018/4/17.
//  Copyright © 2018 gameplex. All rights reserved.
//

import UIKit

extension BaseViewController: BasePresentable, UIStateProtocol {
    func didUIStateChanged(_ state: UIState) {
        self.uiState = state
    }
}
