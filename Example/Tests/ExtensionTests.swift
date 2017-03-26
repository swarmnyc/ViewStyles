//
//  ExtensionTests.swift
//  ViewStyles
//
//  Created by Alex Hartwell on 3/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

class ExtensionsTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testOverrideStylesUIView() {
        let view = UIView().overrideStyles({ view in
            view.backgroundColor = UIColor.black
        })
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testOverrideStylesUITextField() {
        let view = UITextField().overrideStyles({ view in
            view.backgroundColor = UIColor.black
        })
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testOverrideStylesUITextView() {
        let view = UITextView().overrideStyles({ view in
            view.backgroundColor = UIColor.black
        })
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testActAsLabelOnUITextField() {
        let field = UITextField().actAsLabel()
        XCTAssertEqual(field.isEnabled, false)
    }
    
    func testActAsLabelOnUITextView() {
        let view = UITextView().actAsLabel()
        XCTAssertEqual(view.isEditable, false)
        XCTAssertEqual(view.isScrollEnabled, false)
    }
    
    
    func testUpdateAlignmentOnUILabel() {
        let label = UILabel().updateAlignment(.right)
        XCTAssertEqual(label.textAlignment, .right)
    }
    
    func testUpdateAlignmentOnUITextView() {
        let view = UITextView().updateAlignment(.right)
        XCTAssertEqual(view.textAlignment, .right)
    }
    
    func testUpdateAlignmentOnUITextField() {
        let field = UITextField().updateAlignment(.right)
        XCTAssertEqual(field.textAlignment, .right)
    }
    
    func testActAsButtonOnUILabel() {
        let label = UILabel().actAsButton()
        XCTAssertEqual(label.isUserInteractionEnabled, true)
    }
    
    



}
