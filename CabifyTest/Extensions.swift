//
//  Extensions.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(at indexPath: IndexPath, identifier: String) -> T {
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    func registerCell(with identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
}

extension UIViewController {
    func addBlurBackground(with effect: UIBlurEffect.Style = .light) {
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        let blurEffect = UIBlurEffect(style: effect)
        let blurView = UIVisualEffectView(effect: blurEffect)
        if effect == .light {
            blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        blurView.frame = UIScreen.main.bounds
        self.view.insertSubview(blurView, at: 0)
    }
}

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
