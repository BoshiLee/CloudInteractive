//
//  UICollectionViewHelper.swift
//  FlowTagCollectionView
//
//  Created by Boshi Li on 24/01/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        let identifier = String(describing: T.self)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: identifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return T.init()
        }
        return cell
    }
    
    func registerHeaderFooter<T: UICollectionReusableView>(_: T.Type, kind: String) {
        let identifier = String(describing: T.self)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: nil)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier:  identifier)
        }
    }
    
    func dequeueHeaderFooter<T: UICollectionReusableView>(_: T.Type, kind: String, indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            return T.init()
        }
        return view
    }
    
}
