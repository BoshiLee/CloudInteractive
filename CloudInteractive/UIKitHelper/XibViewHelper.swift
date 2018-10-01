//
//  MapViewHelper.swift
//  Bump
//
//  Created by Boshi Li on 01/10/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

struct XibViewHelper<T: BaseXibView> {
    private let xibView: T.Type?
    init(of xibView: T.Type) { self.xibView = xibView }
    func instantiateNib() -> T? {
        let identifier = String(describing: T.self)
        guard let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? T else {
            fatalError("Can't not load Nib \(identifier)")
        }
        return view
    }
}
