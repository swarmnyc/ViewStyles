//
//  ViewShadow.swift
//  Pods
//
//  Created by Alex Hartwell on 3/26/17.
//
//

import Foundation

public struct ViewShadow {
    var offset: CGSize
    var radius: CGFloat
    var opacity: CGFloat
    var color: UIColor
    public init(offset: CGSize, radius: CGFloat, opacity: CGFloat, color: UIColor) {
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
        self.color = color
    }
}
