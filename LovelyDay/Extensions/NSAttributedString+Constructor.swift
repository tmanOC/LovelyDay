//
//  NSAttributedString+Constructor.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/14.
//

import Foundation
import UIKit
extension NSAttributedString {
    /**
    Extension of `NSAttributedString` for quickly making an attributed string
     - Parameter string:The string to build the `NSAttributedString` from
     - Parameter color:The color to render it with
     - Parameter size:The font size of the string
     - Returns: An Immutable `NSAttributedString`
     */
    class func attributedStringWithString(_ string:String,color:UIColor?,size:CGFloat?) -> NSAttributedString {
        let dictionary:[NSAttributedString.Key:Any]
        if let s = size {
            dictionary = [NSAttributedString.Key.foregroundColor:(color ?? UIColor.black),NSAttributedString.Key.font:UIFont.systemFont(ofSize: s)]
        } else {
            dictionary = [NSAttributedString.Key.foregroundColor:(color ?? UIColor.black)]
        }
        return self.init(string: string, attributes: dictionary)
    }
}
