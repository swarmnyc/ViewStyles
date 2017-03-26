//
//  ViewController.swift
//  SWRMViews
//
//  Created by ahartwel on 03/25/2017.
//  Copyright (c) 2017 ahartwel. All rights reserved.
//

import UIKit
import SnapKit
import ViewStyles



class ViewController: UIViewController {
    var ticketView: TicketView = TicketView()
    
    override func loadView() {
        super.loadView()
        self.view = self.ticketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



class TicketView: UIView {
    
    
    lazy var date = ExampleOverrideTextStype.getLabelWithStyle(withText: "Saturday June 12th",
                                                       scaleForScreenSize: true,
                                                       subclass: UILabel.self)
        .overrideStyles({ label in
            label.textAlignment = .left
        })
    
    lazy var title = Title.getTextViewWithStyle(withText: "Test Title Title",
                                                      scaleForScreenSize: true).actAsLabel()
    
    lazy var subtitle = SubTitle.getLabelWithStyle(withText: "Testing Sub title",
                                                  scaleForScreenSize: true)
    
    lazy var avatarNameLabel = AvatarNameLabel.getLabelWithStyle(withText: "Alex Hartwell",
                                                                  scaleForScreenSize: true)
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.didLoad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.didLoad()
    }
    
    func didLoad() {
        self.addSubviews()
        self.setUpConstraints()
    }
    
    func addSubviews() {
        self.date.addToView(self)
        self.title.addToView(self)
        self.subtitle.addToView(self)
        self.avatarNameLabel.addToView(self)
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 40
        self.date.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.top.equalTo(self).offset(padding)
            make.width.equalTo(self).inset(-padding)
        })
        
        self.title.snp.remakeConstraints({ make in
            make.top.equalTo(self.date.snp.bottom).offset(padding * 0.25)
            make.left.equalTo(self.date)
            make.width.equalTo(self).inset(-padding)
        })
        
        self.subtitle.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.top.equalTo(self.title.snp.bottom).offset(padding * 10)
            make.right.equalTo(self).inset(padding)
        })
        
        self.avatarNameLabel.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.bottom.equalTo(self).inset(padding)
            make.width.equalTo(self).multipliedBy(0.4)
        })
        
    }
    
    
    
}
