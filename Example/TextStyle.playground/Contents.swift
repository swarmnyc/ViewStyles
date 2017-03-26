//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport






public protocol TextStyle {
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
    var placeholderStyles: TextStyle { get } //not working or implemented yet

    init()
}

extension TextStyle {
    
    static func getLabelWithStyle(withText text: String) -> UILabel {
        let style = Self()
        return style.getLabelWithStyle(withText: text)
    }
    
    static func getLabelWithStyleAndParagraphAttributes(withText text: String) -> UILabel {
        let style = Self()
        return style.getLabelWithStyleAndParagraphAttributes(withText: text)
    }
  
    static func getTextViewWithStyle(withText text: String) -> UITextView {
        let style = Self()
        return style.getTextViewWithStyle(withText: text)
    }
    
    static func getTextViewWithStyleAndParagraphAttributes(withText text: String) -> UITextView {
        let style = Self()
        return style.getTextViewWithStyleAndParagraphAttributes(withText: text)
    }
    
    static func getTextFieldWithStyle(withText text: String) -> UITextField {
        let style = Self()
        return style.getTextFieldWithStyle(withText: text)
    }
    
    static func getTextFieldWithStyleAndParagraphAttributes(withText text: String) -> UITextField {
        let style = Self()
        return style.getTextFieldWithStyleAndParagraphAttributes(withText: text)
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
    
    var lineHeight: CGFloat {
        return self.font.pointSize
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
    
    var placeholderStyles: TextStyle {
        return Self()
    }
    
    var backgroundColor: UIColor {
        return UIColor.clear
    }
    
    func getLabelWithStyle(withText text: String) -> UILabel {
        let label = UILabel()
        label.font = self.font
        label.textColor = self.color
        label.textAlignment = self.alignment
        label.text = self.getTransformedText(text)
        label.backgroundColor = self.backgroundColor
        return label
    }
    
    func getLabelWithStyleAndParagraphAttributes(withText text: String) -> UILabel {
        let label = self.getLabelWithStyle(withText: text)
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: false)
        label.attributedText = attributedString
        return label
    }
    
    func getTextViewWithStyle(withText text: String) -> UITextView {
        let view = UITextView()
        view.font = self.font
        view.textColor = self.color
        view.textAlignment = self.alignment
        view.text = self.getTransformedText(text)
        view.backgroundColor = self.backgroundColor
        return view
    }
    
    func getTextViewWithStyleAndParagraphAttributes(withText text: String) -> UITextView {
        let view = self.getTextViewWithStyle(withText: text)
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: false)
        view.attributedText = attributedString
        return view
    }
    
    func getTextFieldWithStyle(withText text: String) -> UITextField {
        let field = UITextField()
        field.font = self.font
        field.textColor = self.color
        field.textAlignment = self.alignment
        field.text = self.getTransformedText(text)
        field.backgroundColor = self.backgroundColor
        return field
    }
    
    func getTextFieldWithStyleAndParagraphAttributes(withText text: String) -> UITextField {
        let field = self.getTextFieldWithStyle(withText: text)
        let attributedString = self.getAttributedString(withText: text, scaleForScreenSize: false)
        field.attributedText = attributedString
        return field
    }
    
    
    func scaleFontToCurrentScreenSize() -> UIFont {
        let size = UIScreen.main.bounds
        print(size)
        let ratio = size.width / self.designScreenSize.width
        let font = self.font.withSize(self.font.pointSize * ratio)
        return font
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
        var styles = self
        if scaleForScreenSize {
            styles.font = self.scaleFontToCurrentScreenSize()
        }
        return self.getAttributedString(withText: text, withStyle: styles)
    }
    
    fileprivate func getAttributedString(withText text: String, withStyle style: Self) -> NSMutableAttributedString {
        let text = self.getTransformedText(text)
        return NSMutableAttributedString(string: text, attributes: self.getAttributes(withStyle: style))
    }
    
    func getAttributes(withStyle style: Self) -> [String: Any] {
        let paragraphStyles = NSMutableParagraphStyle()
        paragraphStyles.alignment = style.alignment
        paragraphStyles.minimumLineHeight = style.lineHeight
        paragraphStyles.maximumLineHeight = style.lineHeight
        paragraphStyles.paragraphSpacing = style.paragraphSpacing
        return [
            NSFontAttributeName: style.font,
            NSForegroundColorAttributeName: style.color,
            NSKernAttributeName: style.kerning,
            NSParagraphStyleAttributeName: paragraphStyles,
            NSUnderlineStyleAttributeName: style.underlineStyle.rawValue,
            NSUnderlineColorAttributeName: style.color
        ]
    }
}

// MARK: The output of the sketch plugin

struct TitleStyles: TextStyle {
    var font = UIFont.titleFont
    var color = UIColor.OsmosisWhite
    var alignment = NSTextAlignment.left
    var underlineStyle = NSUnderlineStyle.styleSingle
    var kerning = 4.42
    var lineHeight: CGFloat = 41
    var paragraphSpacing: CGFloat = 0
    var isUppercased: Bool = true
    var isLowercased: Bool = false
    var designScreenSize = CGSize(width: 640, height: 1136)
}

struct TestStyles: TextStyle {
    var font = UIFont.titleFont
    var color = UIColor.OsmosisWhite
    var paragraphSpacing: CGFloat = 0
    var kerning: Double = 15
}

struct TicketTitle: TextStyle {
    var font = UIFont(name: "DINCondensed-Bold", size: 72)!
    var color = UIColor.white
    var paragraphSpacing: CGFloat = 32.4
    var kerning: Double = 2.34
    var lineHeight: CGFloat = 84
    var alignment: NSTextAlignment = .left
    var isUppercased: Bool = true
}


public extension UIColor {
    static var OsmosisWhite: UIColor {
        return UIColor.white
    }
}

public extension UIFont {
    static var titleFont: UIFont {
        return UIFont.systemFont(ofSize: 34, weight: UIFontWeightRegular)
    }
}

// MARK: End of Sketch Plugin Output

var playgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
playgroundView.backgroundColor = UIColor.black



PlaygroundPage.current.liveView = playgroundView
var titleLabel = TitleStyles.getLabelWithStyle(withText: "Testing")
titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 70)
playgroundView.addSubview(titleLabel)


var titleLabelParagraphAttributes = TitleStyles.getLabelWithStyleAndParagraphAttributes(withText: "Testing")
titleLabelParagraphAttributes.frame = CGRect(x: 0, y: 70, width: 300, height: 70)
playgroundView.addSubview(titleLabelParagraphAttributes)

var testStyles = TestStyles.getTextFieldWithStyleAndParagraphAttributes(withText: "What what what")
testStyles.frame = CGRect(x: 0, y: 140, width: 300, height: 70)
playgroundView.addSubview(testStyles)


var ticketTest = TicketTitle.getTextFieldWithStyleAndParagraphAttributes(withText: "alessia")
ticketTest.frame = CGRect(x: 0, y: 220, width: 300, height: 90)
playgroundView.addSubview(ticketTest)
