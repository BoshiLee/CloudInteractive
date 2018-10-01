//
// Created by Boshi Li on 2018-01-09.
// Copyright (c) 2018 Boshi Li. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSURL, UIImage>()

final class WebImageView: UIImageView {
    
    struct Configuration {
        var placeholderImage: UIImage? = nil
        var animationDuration: TimeInterval = 0.3
        var animationOptions: UIView.AnimationOptions = .transitionCrossDissolve
    }

    fileprivate var currentTask: URLSessionDataTaskProtocol? {
        didSet {
            oldValue?.cancel()
            currentTask?.resume()
        }
    }

    fileprivate var originRequsetURL: URL?
    var responseURL: URL?

    public var configuration = Configuration()

}
// Web Request
extension WebImageView {

    public func load(url: URL) {
        self.originRequsetURL = url
        let configuration = self.configuration
        image = configuration.placeholderImage
        
        if let image = CacheHelper.shared.loadImage(imageURL: url) {
            setup(image: image, of: configuration)
        } else {
            currentTask = UIImageAPIManager(session: URLSession.shared).downloadImage(of: url, isCompression: true, completionHandler: { [weak self] (image) in
                guard let weakSelf = self else { return }
                weakSelf.setup(image: image, of: configuration)
            })
        }
    }
    
    private func setup(image: UIImage?, of configuration: Configuration) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: configuration.animationDuration, options: configuration.animationOptions, animations: {
                self.image = image
            }, completion: nil)
        }
    }
}
