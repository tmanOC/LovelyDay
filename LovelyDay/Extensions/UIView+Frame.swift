//
//  UIView+Frame.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/14.
//

import Foundation
import UIKit

/**
 `UIView` extension for making it easier to layout `UIView`s
 */
extension UIView {
    var x:CGFloat {get{
        return self.frame.origin.x
        }set(value){
            self.frame.origin.x = value
        }}
    var y:CGFloat {get{
        return self.frame.origin.y
        }set(value){
            self.frame.origin.y = value
        }}
    var width:CGFloat {get{
        return self.frame.size.width
        }set(value){
            self.frame.size.width = value
        }}
    var height:CGFloat {get{
        return self.frame.size.height
        }set(value){
            self.frame.size.height = value
        }}
    var bottom:CGFloat {get{
            return self.y + self.height
        }}
    var right:CGFloat {get{
            return self.x + self.width
        }}

    var size:CGSize {get{
            return self.frame.size
        }set(value){
            self.frame.size = value
        }}
    var origin:CGPoint {get {
            return self.frame.origin
        }set(value){
            self.frame.origin = value
        }}
}
