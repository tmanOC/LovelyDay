//
//  UIColor+RGB.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/14.
//

import Foundation
import UIKit
extension UIColor {
    /**
    Convenience initializer parameters are between 0 and 255. Note there is no
     alpha argument. Use the built in `withAlphaComponent(_:)`
     - parameter red: Float value between 0 and 255
     - Parameter green: Float value between 0 and 255
     - Parameter blue: Float value between 0 and 255
     - Returns: UIColor object notice
     */
    convenience init(red:CGFloat,green:CGFloat,blue:CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}
