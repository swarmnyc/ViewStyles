//
//  UIKit+Extensions.swift
//  Pods
//
//  Created by Alex Hartwell on 7/13/17.
//
//

import Foundation
import UIKit

extension UILabel: UITextStyleAttributes {
    public var viewStyleFont: UIFont {
        get {
            return self.font
        }
        set {
            self.font = newValue
        }
    }
    
    public var viewStyleText: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
    
    public var viewStyleTextColor: UIColor! {
        get {
            return self.textColor
        }
        set {
            self.textColor = newValue
        }
    }
    
    public var viewStyleAttributedText: NSAttributedString? {
        get {
            return self.attributedText
        }
        set {
            self.attributedText = newValue
        }
    }
    
}
extension UITextView: UITextStyleAttributes {
    public var viewStyleFont: UIFont {
        get {
            return self.font ?? UIFont.systemFont(ofSize: 12)
        }
        set {
            self.font = newValue
        }
    }
    
    public var viewStyleText: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
    
    public var viewStyleTextColor: UIColor! {
        get {
            return self.textColor ?? UIColor.white
        }
        set {
            self.textColor = newValue
        }
    }
    
    public var viewStyleAttributedText: NSAttributedString? {
        get {
            return self.attributedText
        }
        set {
            self.attributedText = newValue ?? NSAttributedString()
        }
    }
}
extension UITextField: UITextStyleAttributes {
    public var viewStyleFont: UIFont {
        get {
            return self.font ?? UIFont.systemFont(ofSize: 12)
        }
        set {
            self.font = newValue
        }
    }
    
    public var viewStyleText: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
    
    public var viewStyleTextColor: UIColor! {
        get {
            return self.textColor ?? UIColor.white
        }
        set {
            self.textColor = newValue
        }
    }
    
    public var viewStyleAttributedText: NSAttributedString? {
        get {
            return self.attributedText
        }
        set {
            self.attributedText = newValue ?? NSAttributedString()
        }
    }
}
