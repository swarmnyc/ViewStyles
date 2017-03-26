//
//  ViewStyleTests.swift
//  ViewStyles
//
//  Created by Alex Hartwell on 3/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import ViewStyles

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

class ViewStyleTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        self.recordMode = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBlankStyle() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = BlankView.createView()
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        containerView.addSubview(view)
        FBSnapshotVerifyView(containerView)
        FBSnapshotVerifyLayer(containerView.layer)
    }
    
    func testViewWithBorderOnly() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = TestStyle.createView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        containerView.addSubview(view)
        FBSnapshotVerifyView(containerView)
        FBSnapshotVerifyLayer(containerView.layer)
    }
    
    func testViewWithBorderAndShadow() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = TestStyle3.createView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        containerView.addSubview(view)
        FBSnapshotVerifyView(containerView)
        FBSnapshotVerifyLayer(containerView.layer)
    }
    
    func testOverridingViewStyles() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = TestStyle3.createView(overrideStyles: { style in
            style.shadow = nil
        })
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        containerView.addSubview(view)
        FBSnapshotVerifyView(containerView)
        FBSnapshotVerifyLayer(containerView.layer)
    }
    
    
    
}
