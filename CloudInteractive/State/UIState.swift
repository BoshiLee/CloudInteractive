//
//  UIState.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/6.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import UIKit

typealias StateAction = (() -> Void)?

// MARK: - UIState
///A list of states. Binding data content to specific view
enum UIState {
    case initial
    case loading(LoadingUIState)
    case loaded(LoadedUIState) //此state用不到，移至各個 VC的 delegate內變更UI
    case error(NetworkingError, StateAction)
    case empty(String)
}
// MARK: - Loaded時，是否 UI 會改變。為了hasData
enum LoadedUIState {
    case uiChange
    case uiNotChange
}
// MARK: - Loading
enum LoadingUIState {
    case syetem
    case normalLoading
    case tableViewBottomLoading //在willDisplay中，判斷bottomLoadingView是否為nil，若非nil，執行initTableViewBottomLoading，將tableViewBottomLoadingView丟入
}
enum UIStateViewTag: Int {
    case loadingSystem = 10
    case loadingCoveredWithSystem = 11
    case loadingNonCoveredWithSystem = 12
    case tableViewBottomLoading = 13
    
    case backgroundNetworkingNoConnect = 20
    
    case errorViewWithAction = 30 //有重新整理的按鈕
    case errorHintWithAction = 31 //有重新整理的按鈕
    case errorViewWithoutAction = 32
    case errorHintWithoutAction = 33
    
    case emptyView = 40
}
// MARK: - UIStateProtocol
///For UIState implementation
protocol UIStateProtocol: AnyObject {
    var hasData: Bool { get set }
    var uiState: UIState { get set }
    
    var lastStateViewTag: Int { get set }
    
    // TODO: 加入各個StateView，宣告為optional type
    //    var loadingViewCovered:
    //    var loadingViewNonCovered:
    //    var bottomLoadingView:
    var errorView: ErrorView? { get }
    //    var hintView:
    var emptyView: EmptyView? { get }
    //    var backgroundNetworkingNoConnectHint:
    var indicator: UIView? { get }
}

extension UIStateProtocol where Self: BaseViewController {
    func updateUIState() {
        if case .loaded(let loadedUIState) = uiState, case .uiChange = loadedUIState { hasData = true }
        switch uiState {
        case .loading(let loadingUIState):
            //原本是11，後來來了其他的loading，不能把11拿掉
            if (lastStateViewTag != 11) {
                removeStateView(of: lastStateViewTag)
                lastStateViewTag = initLoadingStateView(of: loadingUIState, hasData: hasData) }
        case let .error(networkError, action):
            //原本是30，後來來了其他的error，不能把30拿掉
            if (lastStateViewTag != 30) {
                removeStateView(of: lastStateViewTag)
                lastStateViewTag = initErrorStateView(of: networkError, hasData: hasData, with: action) }
        case .empty(let emptyMessage):
            removeStateView(of: lastStateViewTag)
            lastStateViewTag = initEmptyStateView(for: emptyMessage)
        case .loaded:
            removeStateView(of: lastStateViewTag)
            lastStateViewTag = 999
        default:
            break
        }
    }
    private func removeStateView(of lastStateViewTag: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        view.viewWithTag(lastStateViewTag)?.removeFromSuperview()
        
    }
    
    //給 tag, frame
    private func initLoadingStateView(of loadingState: LoadingUIState, hasData: Bool) -> Int {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        switch loadingState {
        case .tableViewBottomLoading:
            //初始化StateView，給tag
            //不需給frame, addsubview
            return UIStateViewTag.tableViewBottomLoading.rawValue
        case .syetem:
            //不需給tag, frame, addsubview
            return UIStateViewTag.loadingSystem.rawValue
        case .normalLoading:
            if hasData {
                //初始化StateView，給tag, frame, addsubview
                return UIStateViewTag.loadingNonCoveredWithSystem.rawValue
            } else {
                //初始化StateView，給tag, frame, addsubview
                indicator = UIView(frame: CGRect.zero)
                indicator?.backgroundColor = UIColor.red
                addSubView(indicator!, with: view.bounds, tag: UIStateViewTag.loadingCoveredWithSystem.rawValue, animationBlock: nil)
                return UIStateViewTag.loadingCoveredWithSystem.rawValue
            }
        }
    }
    
    private func initErrorStateView(of error: NetworkingError, hasData: Bool,with action: StateAction) -> Int {
        var errorContent = (title: "", description: "")
        //給定相對應的errorContent(title, description)
        switch error {
        case .requestError(let errorModel):
            errorContent = process(errorModel: errorModel)
        case .noNetworkingConnect:
            errorContent = (title: "", description: "無網路....")
        default:
            errorContent = (title: "", description: "發生錯誤....")
        }
        
        switch hasData {
        case true:
            if action == nil {
                //初始化StateView，給errorContent, tag, frame, addsubview
                return UIStateViewTag.errorHintWithoutAction.rawValue
            } else {
                //初始化StateView，給errorContent, tag, frame, addsubview, action
                return UIStateViewTag.errorHintWithAction.rawValue
            }
        case false:
            if action == nil {
                //初始化StateView，給errorContent, tag, frame, addsubview
                return UIStateViewTag.errorViewWithoutAction.rawValue
            } else {
                //初始化StateView，給errorContent, tag, frame, addsubview, action
                return UIStateViewTag.errorViewWithAction.rawValue
            }
        }
    }
    
    private func initEmptyStateView(for content: String) -> Int {
        return UIStateViewTag.emptyView.rawValue
    }
    
    private func addSubView(_ stateView: UIView, with frame: CGRect, tag: Int, animationBlock: (() -> Void)?){
        stateView.frame = frame
        stateView.tag = tag
        view.addSubview(stateView)
        if animationBlock != nil { animationBlock!() }
    }
    // MARK: - 在WillDisplay中執行，判斷bottomLoadingView是否為nil，若非nil，執行initTableViewBottomLoading，將tableViewBottomLoadingView丟入
    func initTableViewBottomLoading(_ tableView: UITableView,with loadingView: UIView ,forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            tableView.tableFooterView = loadingView
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    private func process(errorModel: ErrorModel) -> (title: String, description: String) {
        //與使用者相關，故要告知使用者目前情況
        switch errorModel.code {
        case 6: // user didnot login
            return ("", "尚未登入")
        case 100, 101, 102, 103, 104, 105:
            return ("", "使用者相關")
        default:
            return ("", "其他錯誤....")
        }
    }
}

