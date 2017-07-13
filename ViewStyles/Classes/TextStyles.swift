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
    var font: UIFont {get set}
    var textColor: UIColor  {get set}
    var textAlignment: NSTextAlignment {get set}
    var text: String? {get set}
    var attributedText: NSAttributedString? {get set}
}

extension UILabel : UITextStyleAttributes {}
extension UITextView : UITextStyleAttributes {}
extension UITextField : UITextStyleAttributes {}

public extension TextStyle {
    public static func getLabelWithStyle(withText text: String, scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)? = nil, subclass: UILabel.Type = UILabel.self) -> UILabel {
        var style = Self()
        if scaleForScreenSize {
            style.font = style.scaleFontToCurrentScreenSize()
        }
        overrideStyles?(&style)
        return style.getLabelWithStyleAndParagraphAttributes(withText: text, scaleForScreenSize: scaleForScreenSize, subclass: subclass)
    }

    public static func getTextViewWithStyle(withText text: String, scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)? = nil, subclass: UITextView.Type = UITextView.self) -> UITextView {
        var style = Self()
        if scaleForScreenSize {
            style.font = style.scaleFontToCurrentScreenSize()
        }
        overrideStyles?(&style)
        return style.getTextViewWithStyleAndParagraphAttributes(withText: text, scaleForScreenSize: scaleForScreenSize, subclass: subclass)
    }

    public static func getTextFieldWithStyle(withText text: String, scaleForScreenSize: Bool, overrideStyles: ((inout Self) -> Void)? = nil, subclass: UITextField.Type = UITextField.self) -> UITextField {
        var style = Self()
        if scaleForScreenSize {
            style.font = style.scaleFontToCurrentScreenSize()
        }
        overrideStyles?(&style)
        return style.getTextFieldWithStyleAndParagraphAttributes(withText: text, scaleForScreenSize: scaleForScreenSize, subclass: subclass)
    }

    public static func getLabelWithStyle(
        withText text: String,
        scaleForScreenSize: Bool,
        overrideStyles: ((inout Self) -> Void)? = nil,
        subclass: UILabel.Type = UILabel.self) -> UITextStyleAttributes {
        var style = Self()

        if scaleForScreenSize {
            style.font = style.scaleFontToCurrentScreenSize()
        }
        overrideStyles?(&style)
        return style.getLabelWithStyleAndParagraphAttributes(
            withText: text,
            scaleForScreenSize: scaleForScreenSize,
            subclass: subclass)
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
        let label = self.getLabelWithStyle(withText: text, subclass: subclass)
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: scaleForScreenSize)
        label.attributedText = attributedString
        return label
    }

    func applyStyle(toView: inout UITextStyleAttributes) -> UITextStyleAttributes {

        toView.font = self.font
        toView.textColor = self.color
        toView.textAlignment = self.alignment

        toView.text = self.getTransformedText(toView.text)
    }
    
    func getLabelWithStyle(withText text: String, subclass: UILabel.Type) -> UILabel {
        var style = self
        var label = subclass.init()
        label.font = style.font
        label.textColor = style.color
        label.textAlignment = style.alignment
        label.text = style.getTransformedText(text)
        self.addStylesToView(label)
        self.labelSetUpBlock?(&label)
        return label
    }
    
    
    func getTextViewWithStyle(withText text: String, subclass: UITextView.Type) -> UITextView {
        var view = subclass.init()
        view.font = self.font
        view.textColor = self.color
        view.textAlignment = self.alignment
        view.text = self.getTransformedText(text)
        view.backgroundColor = self.backgroundColor
        view.textContainer.lineBreakMode = .byWordWrapping
        view.textContainer.lineFragmentPadding = 0
        self.addStylesToView(view)
        self.textViewSetUpBlock?(&view)
        return view
    }
    
    func getTextViewWithStyleAndParagraphAttributes(withText text: String, scaleForScreenSize: Bool, subclass: UITextView.Type = UITextView.self) -> UITextView {
        let view = self.getTextViewWithStyle(withText: text, subclass: subclass)
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: scaleForScreenSize)
        view.attributedText = attributedString
        return view
    }
    
    func getTextFieldWithStyle(withText text: String, subclass: UITextField.Type = UITextField.self) -> UITextField {
        var field = subclass.init()
        field.font = self.font
        field.textColor = self.color
        field.textAlignment = self.alignment
        field.text = self.getTransformedText(text)
        field.backgroundColor = self.backgroundColor
        self.addStylesToView(field)
        self.textFieldSetUpBlock?(&field)
        return field
    }
    
    func getTextFieldWithStyleAndParagraphAttributes(withText text: String, scaleForScreenSize: Bool, subclass: UITextField.Type = UITextField.self) -> UITextField {
        let field = self.getTextFieldWithStyle(withText: text, subclass: subclass)
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: scaleForScreenSize)
        field.attributedText = attributedString
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
        if scaleForScreenSize {
            lineHeight = lineHeight * self.getRatioToScreenSize()
            paragraphSpacing = lineHeight * self.getRatioToScreenSize()
        }
        paragraphStyles.minimumLineHeight = lineHeight
        paragraphStyles.maximumLineHeight = lineHeight
        paragraphStyles.paragraphSpacing = paragraphSpacing
        return [
            NSFontAttributeName: style.font,
            NSForegroundColorAttributeName: style.color,
            NSKernAttributeName: style.kerning,
            NSParagraphStyleAttributeName: paragraphStyles,
            NSUnderlineStyleAttributeName: style.underlineStyle.rawValue,
            NSUnderlineColorAttributeName: style.color
        ]
    }

    func addStylesToLabel(_ label: UILabel, scaleForScreenSize: <#T##Bool##Swift.Bool#>) -> UILabel {

        self.addStylesToView(label)

        label.attributedText = getAttributedString(withText: label.text, scaleForScreenSize: scaleForScreenSize)

    }
}
