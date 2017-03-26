//
//  Extensions.swift
//  Pods
//
//  Created by Alex Hartwell on 3/26/17.
//
//

import Foundation
import UIKit

extension UIView {
    /// Calls a closure where you can update the views styling and then returns the updated view
    ///
    /// - Parameter styleBlock: the closure to update the view in
    /// - Returns: the updated view
    public func overrideStyles(_ styleBlock: (UIView) -> Void) -> UIView {
        var label = self
        styleBlock(label)
        return label
    }

    public func addToView(_ view: UIView) {
        view.addSubview(self)
    }
    
}

public extension UILabel {

    public func updateAlignment(_ alignment: NSTextAlignment) -> UILabel {
        self.textAlignment = alignment
        return self
    }
    /// Calls a closure where you can update the views styling and then returns the updated view
    ///
    /// - Parameter styleBlock: the closure to update the view in
    /// - Returns: the updated view

    public func actAsButton() -> UILabel {
        self.isUserInteractionEnabled = true
        return self
    }
    
    public override func overrideStyles(_ styleBlock: (UILabel) -> Void) -> UILabel {
        var label = self
        styleBlock(label)
        return label
    }
}

public extension UITextField {
    /// Remove editing and scrolling capabilities from the text field, make it act as a label
    ///
    /// - Returns: the updated text field
    public func actAsLabel() -> UITextField {
        self.isEnabled = false
        return self
    }
    
    public func updateAlignment(_ alignment: NSTextAlignment) -> UITextField {
        self.textAlignment = alignment
        return self
    }
    /// Calls a closure where you can update the views styling and then returns the updated view
    ///
    /// - Parameter styleBlock: the closure to update the view in
    /// - Returns: the updated view
    public override func overrideStyles(_ styleBlock: (UITextField) -> Void) -> UITextField {
        var label = self
        styleBlock(label)
        return label
    }
}

public extension UITextView {
    /// Remove editing and scrolling capabilities from the text view, make it just display multiline text
    ///
    /// - Returns: the updated text view
    public func actAsLabel() -> UITextView {
        self.isEditable = false
        self.isScrollEnabled = false
        return self
    }
    public func updateAlignment(_ alignment: NSTextAlignment) -> UITextView {
        self.textAlignment = alignment
        return self
    }
    /// Calls a closure where you can update the views styling and then returns the updated view
    ///
    /// - Parameter styleBlock: the closure to update the view in
    /// - Returns: the updated view
    public override func overrideStyles(_ styleBlock: (UITextView) -> Void) -> UITextView {
        var label = self
        styleBlock(label)
        return label
    }
}
