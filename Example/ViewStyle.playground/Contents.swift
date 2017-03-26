//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


public struct ViewShadow {
    var offset: CGSize
    var radius: CGFloat
    var opacity: CGFloat
    var color: UIColor
}

public struct ViewBorder {
    var width: CGFloat
    var color: UIColor
}

public protocol ViewStyle {
    var backgroundColor: UIColor { get }
    var cornerRadius: CGFloat { get }
    var shadow: ViewShadow? { get }
    var border: ViewBorder? { get }
    var clipView: Bool { get }
    init()
}

extension ViewStyle {
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
    
    static func createView() -> UIView {
        let style = Self()
        return style.getView()
    }
    
    func getView() -> UIView {
        var view = UIView()
        view = self.addStylesToView(view)
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



struct TestStyle: ViewStyle {
    var backgroundColor: UIColor = UIColor.green
    var cornerRadius: CGFloat = 10
    var border: ViewBorder? = ViewBorder(width: 10, color: UIColor.black)
}

struct TestStyle2: ViewStyle {
    var backgroundColor: UIColor = UIColor.red
    var cornerRadius: CGFloat = 1
    var border: ViewBorder? = ViewBorder(width: 2, color: .white)
    var shadow: ViewShadow? = ViewShadow(offset: CGSize(width: -5, height: -5), radius: 10, opacity: 1, color: UIColor.black)
}

struct TestStyle3: ViewStyle {
    var backgroundColor: UIColor = UIColor.clear
    var shadow: ViewShadow? = ViewShadow(offset: CGSize(width: 0, height: 0), radius: 4, opacity: 0.4, color: UIColor.black)
    var border: ViewBorder? = ViewBorder(width: 1, color: .red)
}


let playgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 700))
playgroundView.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = playgroundView


let testView = TestStyle.createView()
testView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)


playgroundView.addSubview(testView)




let viewInBlur = TestStyle2.createView()
viewInBlur.frame = CGRect(x: 15, y: 15, width: 40, height: 40)


var slider = UISlider()
slider = TestStyle3().addStylesToView(slider)
slider.frame = CGRect(x: 50, y: 100, width: 150, height: 40)
playgroundView.addSubview(slider)
playgroundView.addSubview(viewInBlur)







