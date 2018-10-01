//
//  ViewControllerHelper.swift
//  Bump
//
//  Created by Boshi Li on 2017-09-10.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
    case map = "Map"
    
    private func instantiateStoryboard () -> UIStoryboard {
        let sb = UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        return sb
    }
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        let identifier = String(describing: T.self)
        guard let vc =  instantiateStoryboard().instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("View Controller can't not be recognized")
        }
        return vc
    }
}

protocol ViewControllerTransitionable: AnyObject { }

extension ViewControllerTransitionable where Self: UIViewController {
    
    func present<T: UIViewController>(_: T.Type, of storyboardName: StoryboardName, completion: ((_ vc: T)->())? = nil) {
        let vc = storyboardName.instantiateViewController(T.self)
        if let completion = completion { completion(vc) }
        present(vc, animated: false, completion: nil)
    }
    
    func pushUnderNavigationController<T: UIViewController>(_: T.Type, of storyboardName: StoryboardName, completion: ((_ vc: T)->())? = nil) {
        let vc = storyboardName.instantiateViewController(T.self)
        if let completion = completion { completion(vc) }
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func presentNaviagtionController<T: UIViewController>(rootViewController viewController: T.Type, of storyboardName: StoryboardName, completion: ((_ vc: T)->())? = nil) {
        let vc = storyboardName.instantiateViewController(T.self)
        let navVC = UINavigationController(rootViewController: vc)
        if let completion = completion { completion(vc) }
        present(navVC, animated: true, completion: nil)
    }
}

protocol SetViewControllersAble: AnyObject { }

extension SetViewControllersAble where Self: UINavigationController {
    
    func set<T: UIViewController>(_: T.Type, of storyboardName: StoryboardName, completion: ((_ vc: T)->())? = nil) {
        let vc = storyboardName.instantiateViewController(T.self)
        if let completion = completion { completion(vc) }
        setViewControllers([vc], animated: false)
    }
}
