//
//  TextStyles.swift
//  Pods
//
//  Created by Alex Hartwell on 3/26/17.
//
//

import Foundation
import UIKit

public protocol TextStyle: ViewStyle {
    //font properties
    var font: UIFont { get set }
    var color: UIColor { get }
    var alignment: NSTextAlignment { get }
    var underlineStyle: NSUnderlineStyle { get }
    //paragraph styles
    var kerning: Double { get }
    var lineHeight: CGFloat { get }
    var paragraphSpacing: CGFloat { get }
    //Text Transform Properties
    var isUppercased: Bool { get }
    var isLowercased: Bool { get }
    var designScreenSize: CGSize { get }
    //Misc Properties
    var backgroundColor: UIColor { get }
    
    var labelSetUpBlock: ((inout UILabel) -> Void)? { get }
    var textFieldSetUpBlock: ((inout UITextField) -> Void)? { get }
    var textViewSetUpBlock: ((inout UITextView) -> Void)? { get }
    
    init()
}

public protocol UITextStyleAttributes {
    var viewStyleFont: UIFont {get set}
    var viewStyleTextColor: UIColor! {get set}
    var textAlignment: NSTextAlignment {get set}
    var viewStyleText: String? {get set}
    var viewStyleAttributedText: NSAttributedString? {get set}
}


public extension TextStyle {
    public static func getLabelWithStyle(withText text: String, scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)? = nil, subclass: UILabel.Type = UILabel.self) -> UILabel {
        let style = Self.createStyle(scaleForScreenSize: scaleForScreenSize, overrideStyles: overrideStyles)
        return style.getLabelWithStyleAndParagraphAttributes(withText: text, scaleForScreenSize: scaleForScreenSize, subclass: subclass)
    }
    
    public static func applyStyle(toLabel label: UILabel, withText text: String, scaleForScreenSize: Bool) {
        let style = Self.createStyle(scaleForScreenSize: scaleForScreenSize, overrideStyles: nil)
        _ = style.applyTextStyle(toView: label, withText: text)
        _ = style.applyAttributedText(toView: label, withText: text, scaleForScreenSize: scaleForScreenSize)
    }

    public static func getTextViewWithStyle(withText text: String, scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)? = nil, subclass: UITextView.Type = UITextView.self) -> UITextView {
        let style = Self.createStyle(scaleForScreenSize: scaleForScreenSize, overrideStyles: overrideStyles)
        return style.getTextViewWithStyleAndParagraphAttributes(withText: text, scaleForScreenSize: scaleForScreenSize, subclass: subclass)
    }
    
    public static func applyStyle(toTextView textView: UITextView, withText text: String, scaleForScreenSize: Bool) {
        let style = Self.createStyle(scaleForScreenSize: scaleForScreenSize, overrideStyles: nil)
        _ = style.applyTextStyle(toView: textView, withText: text)
        _ = style.applyAttributedText(toView: textView, withText: text, scaleForScreenSize: scaleForScreenSize)
    }

    public static func getTextFieldWithStyle(withText text: String, scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)? = nil, subclass: UITextField.Type = UITextField.self) -> UITextField {
        let style = Self.createStyle(scaleForScreenSize: scaleForScreenSize, overrideStyles: overrideStyles)
        return style.getTextFieldWithStyleAndParagraphAttributes(withText: text, scaleForScreenSize: scaleForScreenSize, subclass: subclass)
    }
    
    public static func applyStyle(toTextField textField: UITextField, withText text: String, scaleForScreenSize: Bool) {
        let style = Self.createStyle(scaleForScreenSize: scaleForScreenSize, overrideStyles: nil)
        _ = style.applyTextStyle(toView: textField, withText: text)
        _ = style.applyAttributedText(toView: textField, withText: text, scaleForScreenSize: scaleForScreenSize)
    }
    
    
    
    
    public static func createStyle(scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)?) -> Self {
        var style = Self()
        if scaleForScreenSize {
            style.font = style.scaleFontToCurrentScreenSize()
        }
        overrideStyles?(&style)
        return style
    }


    var kerning: Double {
        return 0
    }
    
    var color: UIColor {
        return UIColor.black
    }
    
    var alignment: NSTextAlignment {
        return .center
    }
    
    var paragraphSpacing: CGFloat {
        return 0
    }
    
    var lineHeight: CGFloat {
        return self.font.lineHeight
    }
    
    var underlineStyle: NSUnderlineStyle {
        return .styleNone
    }
    
    var isUppercased: Bool {
        return false
    }
    
    var isLowercased: Bool {
        return false
    }
    
    var designScreenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    var backgroundColor: UIColor {
        return UIColor.clear
    }
    
    var labelSetUpBlock: ((inout UILabel) -> Void)? {
        return nil
    }
    
    var textFieldSetUpBlock: ((inout UITextField) -> Void)? {
        return nil
    }
    
    var textViewSetUpBlock: ((inout UITextView) -> Void)? {
        return nil
    }
    
    
    func getLabelWithStyleAndParagraphAttributes(withText text: String, scaleForScreenSize: Bool, subclass: UILabel.Type = UILabel.self) -> UILabel {
        var label = self.getLabelWithStyle(withText: text, subclass: subclass)
        label = self.applyAttributedText(toView: label, withText: text, scaleForScreenSize: scaleForScreenSize)
        return label
    }

    func applyTextStyle<T: UITextStyleAttributes>(toView view: T, withText text: String) -> T {
        var view = view
        view.viewStyleFont = self.font
        view.viewStyleTextColor = self.color
        view.textAlignment = self.alignment
        view.viewStyleText = self.getTransformedText(text)
        if let view = view as? UITextView {
            view.textContainer.lineBreakMode = .byWordWrapping
            view.textContainer.lineFragmentPadding = 0
        }
        if let view = view as? UIView {
            _ = self.addStylesToView(view)
        }
        return view
    }
    
    func applyAttributedText<T: UITextStyleAttributes>(toView view: T, withText text: String, scaleForScreenSize: Bool) -> T {
        var view = view
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: scaleForScreenSize)
        view.viewStyleAttributedText = attributedString
        return view
    }
    
    func getLabelWithStyle(withText text: String, subclass: UILabel.Type) -> UILabel {
        var label = subclass.init()
        label = self.applyTextStyle(toView: label, withText: text)
        self.labelSetUpBlock?(&label)
        return label
    }
    
    
    
    func getTextViewWithStyle(withText text: String, subclass: UITextView.Type) -> UITextView {
        var view = subclass.init()
        view = self.applyTextStyle(toView: view, withText: text)
        self.textViewSetUpBlock?(&view)
        return view
    }
    
    func getTextViewWithStyleAndParagraphAttributes(withText text: String, scaleForScreenSize: Bool, subclass: UITextView.Type = UITextView.self) -> UITextView {
        var view = self.getTextViewWithStyle(withText: text, subclass: subclass)
        view = self.applyAttributedText(toView: view, withText: text, scaleForScreenSize: scaleForScreenSize)
        return view
    }
    
    func getTextFieldWithStyle(withText text: String, subclass: UITextField.Type = UITextField.self) -> UITextField {
        var field = subclass.init()
        field = self.applyTextStyle(toView: field, withText: text)
        self.textFieldSetUpBlock?(&field)
        return field
    }
    
    func getTextFieldWithStyleAndParagraphAttributes(withText text: String, scaleForScreenSize: Bool, subclass: UITextField.Type = UITextField.self) -> UITextField {
        var field = self.getTextFieldWithStyle(withText: text, subclass: subclass)
        field = self.applyAttributedText(toView: field, withText: text, scaleForScreenSize: scaleForScreenSize)
        return field
    }
    
    func scaleFontToCurrentScreenSize() -> UIFont {
        let ratio = self.getRatioToScreenSize()
        let font = self.font.withSize(self.font.pointSize * ratio)
        return font
    }
    
    fileprivate func getRatioToScreenSize() -> CGFloat {
        let size = UIScreen.main.bounds
        let ratio = size.width / self.designScreenSize.width
        return ratio
    }
    
    func getTransformedText(_ text: String) -> String {
        var text = text
        if isUppercased {
            text = text.uppercased()
        }
        if isLowercased {
            text = text.lowercased()
        }
        return text
    }
    
    func getAttributedString(withText text: String, scaleForScreenSize: Bool) -> NSMutableAttributedString {
        let styles = self
        return self.getAttributedString(withText: text, withStyle: styles, scaleForScreenSize: scaleForScreenSize)
    }
    
    fileprivate func getAttributedString(withText text: String, withStyle style: Self, scaleForScreenSize: Bool) -> NSMutableAttributedString {
        let text = self.getTransformedText(text)
        return NSMutableAttributedString(string: text, attributes: self.getAttributes(withStyle: style, scaleForScreenSize: scaleForScreenSize))
    }
    
    func getAttributes(withStyle style: Self, scaleForScreenSize: Bool) -> [String: Any] {
        let paragraphStyles = NSMutableParagraphStyle()
        paragraphStyles.alignment = style.alignment
        var lineHeight = style.lineHeight
        var paragraphSpacing = style.paragraphSpacing
        var kerning = style.kerning
        if scaleForScreenSize {
            let ratio = self.getRatioToScreenSize()
            lineHeight = lineHeight * ratio
            paragraphSpacing = paragraphSpacing * ratio
            kerning = kerning * Double(ratio)
        }
        paragraphStyles.minimumLineHeight = lineHeight
        paragraphStyles.maximumLineHeight = lineHeight
        paragraphStyles.paragraphSpacing = paragraphSpacing
        return [
            NSFontAttributeName: style.font,
            NSForegroundColorAttributeName: style.color,
            NSKernAttributeName: kerning,
            NSParagraphStyleAttributeName: paragraphStyles,
            NSUnderlineStyleAttributeName: style.underlineStyle.rawValue,
            NSUnderlineColorAttributeName: style.color
        ]
    }

}
