//
//  UIView+Loader.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/14.
//

import Foundation
import UIKit
class Loader:UIView {
    let view_box:UIView
    let view_spinner:UIActivityIndicatorView
    override init(frame: CGRect) {
        view_spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)

        view_box = UIView()
        super.init(frame: frame)
        view_spinner.startAnimating()
        view_spinner.center = self.center

        //self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view_box.height = view_spinner.height + 30.0
        view_box.width = view_box.height
        view_box.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view_box.center = self.center
        view_box.layer.cornerRadius = 6.0
        self.addSubview(view_box)
        self.addSubview(view_spinner)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func addLoader() {
        if let _ = (self.subviews.first{($0 as? Loader) != nil}) {
           return
        }
        let loader = Loader(frame: self.frame)
        loader.x = 0
        loader.y = 0
        self.addSubview(loader)
    }
    func removeLoader() {
        if let loader = (self.subviews.first{($0 as? Loader) != nil}) {
            loader.removeFromSuperview()
        }
    }
}
