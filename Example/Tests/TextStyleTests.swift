import UIKit
import XCTest
import ViewStyles
import FBSnapshotTestCase


struct TicketTitle: TextStyle {
    var font = UIFont(name: "DINCondensed-Bold", size: 72)!
    var color = UIColor.white
    var paragraphSpacing: CGFloat = 32.4
    var kerning: Double = 2.34
    var lineHeight: CGFloat = 84
    var alignment: NSTextAlignment = .left
    var isUppercased: Bool = true
    var isLowercased: Bool = false
    var designScreenSize: CGSize = CGSize(width: 640, height: 1136)
}

struct BareMinimumTextStyle: TextStyle {
    public var font: UIFont = UIFont.systemFont(ofSize: 12)
}

class TextStyleTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Test Label Factory Methods
    
    func testTextStyleLabel() {
        
        let view = TicketTitle.getLabelWithStyle(withText: "Testing", scaleForScreenSize: false)
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testTextStyleLabelChangeStyle() {
        let view = TicketTitle.getLabelWithStyle(withText: "Testing", scaleForScreenSize: false)
        TicketTitle.applyStyle(toLabel: view, withText: "testing", scaleForScreenSize: false)
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    
    func testTextStyleLabelOverrideIsUppercased() {
        let view = TicketTitle.getLabelWithStyle(withText: "Testing", scaleForScreenSize: false, overrideStyles: {
            styles in
            styles.isUppercased = false
        })
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testTextStyleLabelOverrideMakeLowercased() {
        let view = TicketTitle.getLabelWithStyle(withText: "Testing", scaleForScreenSize: false, overrideStyles: {
            styles in
            styles.isUppercased = false
            styles.isLowercased = true
        })
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    // MARK: Test TextView Factory Methods
    
    func testTextStyleView() {
        let view = TicketTitle.getTextViewWithStyle(withText: "Testing", scaleForScreenSize: false)
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testTextStyleViewOverrideIsUppercased() {
        let view = TicketTitle.getTextViewWithStyle(withText: "Testing", scaleForScreenSize: false, overrideStyles: {
            styles in
            styles.isUppercased = false
        })
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testTextStyleViewOverrideMakeLowercased() {
        let view = TicketTitle.getTextViewWithStyle(withText: "Testing", scaleForScreenSize: false, overrideStyles: {
            styles in
            styles.isUppercased = false
            styles.isLowercased = true
        })
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    // MARK: Test TextField Factory Methods
    
    func testTextStyleField() {
        let view = TicketTitle.getTextFieldWithStyle(withText: "Testing", scaleForScreenSize: false)
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testTextStyleFieldOverrideIsUppercased() {
        let view = TicketTitle.getTextFieldWithStyle(withText: "Testing", scaleForScreenSize: false, overrideStyles: {
            styles in
            styles.isUppercased = false
        })
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    func testTextStyleFieldOverrideMakeLowercased() {
        let view = TicketTitle.getTextFieldWithStyle(withText: "Testing", scaleForScreenSize: false, overrideStyles: {
            styles in
            styles.isUppercased = false
            styles.isLowercased = true
        })
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
    
    // MARK: MISC
    
    func testBareMinimum() {
        let view = BareMinimumTextStyle.getLabelWithStyle(withText: "test", scaleForScreenSize: true)
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        FBSnapshotVerifyLayer(view.layer)
        FBSnapshotVerifyView(view)
    }
    
}
