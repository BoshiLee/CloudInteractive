//
//  BaseXibView.swift
//  CLHealthCare
//
//  Created by Boshi Li on 26/01/2018.
//  Copyright © 2018 Caringloop. All rights reserved.
//

import UIKit

@IBDesignable open class BaseXibView: UIView {

    var contentView: UIView?
    @IBInspectable var nibName: String?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    // MARK: - Visualize xib in storyboard
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
}
