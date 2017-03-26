//
//  ViewStyles.swift
//  Pods
//
//  Created by Alex Hartwell on 3/26/17.
//
//

import Foundation

public struct BlankView: ViewStyle {
    public init() {
    }
}

public protocol ViewStyle {
    var backgroundColor: UIColor { get }
    var cornerRadius: CGFloat { get }
    var shadow: ViewShadow? { get }
    var border: ViewBorder? { get }
    var clipView: Bool { get }
    var viewSetUpBlock: ((inout UIView) -> Void)? { get }
    init()
}

public extension ViewStyle {
    var backgroundColor: UIColor {
        return UIColor.clear
    }
    
    var cornerRadius: CGFloat {
        return 0
    }
    
    var shadow: ViewShadow? {
        return nil
    }
    
    var border: ViewBorder? {
        return nil
    }
    
    var clipView: Bool {
        return false
    }
    
    var viewSetUpBlock: ((inout UIView) -> Void)? {
        return nil
    }
    
    public static func createView(overrideStyles: ((inout Self) -> Void)? = nil) -> UIView {
        var style = Self()
        overrideStyles?(&style)
        return style.getView()
    }
    
    func getView() -> UIView {
        var view = UIView()
        view = self.addStylesToView(view)
        self.viewSetUpBlock?(&view)
        return view
    }
    
    func addStylesToView<T: UIView>(_ view: T) -> T {
        view.backgroundColor = self.backgroundColor
        view.layer.cornerRadius = self.cornerRadius
        if let border = self.border {
            view.layer.borderColor = border.color.cgColor
            view.layer.borderWidth = border.width
        }
        if let shadow = self.shadow {
            view.layer.shadowColor = shadow.color.cgColor
            view.layer.shadowOffset = shadow.offset
            view.layer.shadowRadius = shadow.radius
            view.layer.shadowOpacity = Float(shadow.opacity)
        }
        view.clipsToBounds = self.clipView
        return view
    }
    
}
