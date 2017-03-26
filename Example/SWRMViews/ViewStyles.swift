//
//  ViewStyles.swift
//  SWRMViews
//
//  Created by Alex Hartwell on 3/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ViewStyles


struct Title: TextStyle {
    var font = UIFont(name: "DINCondensed-Bold", size: 72)!
    var color = UIColor.white
    var paragraphSpacing: CGFloat = 32.4
    var kerning: Double = 2.34
    var lineHeight: CGFloat = 84
    var alignment: NSTextAlignment = .left
    var isUppercased: Bool = true
    var designScreenSize: CGSize = CGSize(width: 640, height: 1136)
}

struct SubTitle: TextStyle {
    var font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightRegular)
    var color = UIColor.white
    var paragraphSpacing: CGFloat = 32.4
    var kerning: Double = 5.8
    var lineHeight: CGFloat = 38
    var alignment: NSTextAlignment = .left
    var isUppercased: Bool = true
    var designScreenSize: CGSize = CGSize(width: 640, height: 1136)
}

class ExampleOverrideTextStype: TextStyle {
    var font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightRegular)
    var color: UIColor {
        return UIColor.white
    }
    var paragraphSpacing: CGFloat = 32.4
    var kerning: Double = 1.5
    var lineHeight: CGFloat = 28
    var alignment: NSTextAlignment = .center
    var isUppercased: Bool {
        return false
    }
    var designScreenSize: CGSize = CGSize(width: 640, height: 1136)

    required init() {
    }
}

// if you use classes instead of structs you can override specific properties of the style, but share the rest of them
// if you continue to use structs you can use the overrideStyles closure in the factory methods of TextStyle to override specific properties at the time of creation

class BlankExampleOverrideTextStype: ExampleOverrideTextStype {
    override var color: UIColor {
        return UIColor.black
    }
}


class AvatarNameLabel: ExampleOverrideTextStype {
    override var isUppercased: Bool {
        return false
    }
}
