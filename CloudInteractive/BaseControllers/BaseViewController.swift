//
//  BaseViewController.swift
//  Bump
//
//  Created by Boshi Li on 19/02/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

protocol SamplePresentable: BasePresentable { }

final class SampleViewModel {
    weak var presenter: SamplePresentable!
    init (presenter: SamplePresentable) { self.presenter = presenter }
    func test() {
        presenter.didUIStateChanged(.loading(.normalLoading))
    }
}

class ViewController: BaseViewController, SamplePresentable {
    lazy var viewModel = SampleViewModel(presenter: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.test()
    }
}

class BaseViewController: UIViewController {
    
    var indicator: UIView?
    var hintView: HintView!
    var errorView: ErrorView?
    var loadingView: LoadingView?
    var emptyView: EmptyView?
    
    var hasData: Bool = false
    var lastStateViewTag: Int = 999
    var uiState: UIState = .initial {
        didSet {
            DispatchQueue.main.async {
                self.updateUIState()
            }
        }
    }
    
    var backgroundColor: UIColor {
        get {
            guard let color = self.view.backgroundColor else {
                return .white
            }
            return color
        }
        set {
            self.view.backgroundColor = newValue
        }
    }
    
    private lazy var viewModel = BaseViewModel()
    
    var topbarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 0
        } else {
            return 64
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColor = .white
        self.viewModel.presenter = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.addReachabilityObsever()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.stopReachabilityObesever()
    }
    
    var navigationTitle: String? {
        get {
            return self.navigationItem.title
        }
        set {
            self.navigationItem.title = newValue
        }
    }
    
    // MARK: - Hide Keyboard When Tapped Around
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissSelf() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func showHint(text: String, color: UIColor = .bumpRed) {
        self.initHintView()
        self.hintView.configure(text, textColor: .white, backgroundColor: color)
    }
    
    private func initHintView() {
        guard self.hintView == nil else { return }
        guard let hintView = XibViewHelper(of: HintView.self).instantiateNib() else { return }
        self.hintView = hintView
        self.hintView.frame = CGRect(x: 0, y: 64, width: DeviceSize.width.value, height: 24)
        self.view.addSubview(self.hintView)
    }
}
