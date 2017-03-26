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


struct ButtonStyle: TextStyle {
    public var font: UIFont = UIFont.systemFont(ofSize: 12)
    var border: ViewBorder? = ViewBorder(width: 1, color: .white)
    var color: UIColor = .white
    var alignment: NSTextAlignment = .left
    var cornerRadius: CGFloat = 10
}

var nextButton = ButtonStyle.getLabelWithStyle(withText: "Next",
                                               scaleForScreenSize: false)
    .overrideStyles({ label in
        label.isUserInteractionEnabled = true
    })

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
    
    
    lazy var date = TicketSeatLabels.getLabelWithStyle(withText: "Wed 01.20.16",
                                                       scaleForScreenSize: true,
                                                       subclass: UILabel.self)
        .overrideStyles({ label in
            label.textAlignment = .left
        })
    
    lazy var title = TicketTitle.getTextViewWithStyle(withText: "Alessia Cara",
                                                      scaleForScreenSize: true).actAsLabel()
    
    lazy var venue = VenueTitle.getLabelWithStyle(withText: "Honda Center",
                                                  scaleForScreenSize: true)
    
    
    lazy var ticketInfoContainer = BlankView.createView()
    
    lazy var sectionContainer = BlankView.createView()
    lazy var section = TicketSeatTitle.getLabelWithStyle(withText: " 103 ",
                                                         scaleForScreenSize: true)
                                                        .updateAlignment(.center)
    
    lazy var sectionLabel = TicketSeatLabels.getLabelWithStyle(withText: "Section",
                                                               scaleForScreenSize: true)
                                                                .updateAlignment(.left)
    
    lazy var rowContainer = BlankView.createView()
    
    lazy var row = TicketSeatTitle.getLabelWithStyle(withText: " 5 ",
                                                     scaleForScreenSize: true)
                                                    .updateAlignment(.center)
    
    lazy var rowLabel = TicketSeatLabels.getLabelWithStyle(withText: "Row",
                                                           scaleForScreenSize: true)
    
    
    lazy var seatContainer = BlankView.createView()
    lazy var seat = TicketSeatTitle.getLabelWithStyle(withText: " 12 ",
                                                      scaleForScreenSize: true)
                                                     .updateAlignment(.center)
    
    
    lazy var seatLabel = TicketSeatLabels.getLabelWithStyle(withText: "Seat",
                                                            scaleForScreenSize: true)
    
    
    lazy var avatarNameLabel = AvatarNameLabel.getLabelWithStyle(withText: "Rachel Heatherson",
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
        self.venue.addToView(self)
        self.ticketInfoContainer.addToView(self)
        
        self.sectionContainer.addToView(self.ticketInfoContainer)
        self.section.addToView(self.sectionContainer)
        self.sectionLabel.addToView(self.sectionContainer)
        
        self.rowContainer.addToView(self.ticketInfoContainer)
        self.row.addToView(self.rowContainer)
        self.rowLabel.addToView(self.rowContainer)
        
        self.seatContainer.addToView(self.ticketInfoContainer)
        self.seat.addToView(self.seatContainer)
        self.seatLabel.addToView(self.seatContainer)
        
        self.avatarNameLabel.addToView(self)
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 40
        self.date.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.top.equalTo(self).offset(padding)
            make.width.equalTo(self).multipliedBy(0.6)
            make.height.equalTo(self.date.font.pointSize * 1.25)
        })
        
        self.title.snp.remakeConstraints({ make in
            make.top.equalTo(self.date.snp.bottom).offset(padding * 0.25)
            make.left.equalTo(self.date)
            make.width.equalTo(self).multipliedBy(0.5)
        })
        
        self.venue.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.bottom.equalTo(self.ticketInfoContainer.snp.top).offset(-padding)
            make.right.equalTo(self).inset(padding)
        })
        
        self.ticketInfoContainer.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.right.equalTo(self).inset(padding)
            make.bottom.equalTo(self).inset(padding * 3)
            make.height.equalTo(80)
        })
        
        self.sectionContainer.snp.remakeConstraints({ make in
            make.left.equalTo(self.ticketInfoContainer)
            make.width.equalTo(self.ticketInfoContainer).multipliedBy(0.33)
            make.top.equalTo(self.ticketInfoContainer)
            make.bottom.equalTo(self.ticketInfoContainer)
        })
        
        self.sectionLabel.snp.remakeConstraints({ make in
            make.bottom.equalTo(self.sectionContainer)
            make.left.equalTo(self.sectionContainer)
            make.height.equalTo(self.sectionContainer).multipliedBy(0.25)
        })
        
        self.section.snp.remakeConstraints({ make in
            make.centerX.equalTo(self.sectionLabel)
            make.bottom.equalTo(self.sectionLabel.snp.top)
            make.top.equalTo(self.sectionContainer)
        })
        
        self.rowContainer.snp.remakeConstraints({ make in
            make.left.equalTo(self.sectionContainer.snp.right)
            make.width.equalTo(self.sectionContainer)
            make.top.equalTo(self.ticketInfoContainer)
            make.bottom.equalTo(self.ticketInfoContainer)
        })
        
        self.rowLabel.snp.remakeConstraints({ make in
            make.left.equalTo(self.rowContainer)
            make.right.equalTo(self.rowContainer)
            make.bottom.equalTo(self.rowContainer)
        })
        
        self.row.snp.remakeConstraints({ make in
            make.left.equalTo(self.rowLabel)
            make.right.equalTo(self.rowLabel)
            make.bottom.equalTo(self.rowLabel.snp.top)
            make.top.equalTo(self.ticketInfoContainer)
        })
        
        self.seatContainer.snp.remakeConstraints({ make in
            make.left.equalTo(self.rowContainer.snp.right)
            make.width.equalTo(self.sectionContainer)
            make.top.equalTo(self.ticketInfoContainer)
            make.bottom.equalTo(self.ticketInfoContainer)
        })
        
        self.seatLabel.snp.remakeConstraints({ make in
            make.right.equalTo(self.seatContainer)
            make.left.equalTo(self.seatContainer)
            make.bottom.equalTo(self.seatContainer)
        })
        
        self.seat.snp.remakeConstraints({ make in
            make.left.equalTo(self.seatLabel)
            make.right.equalTo(self.seatLabel)
            make.bottom.equalTo(self.seatLabel.snp.top)
            make.top.equalTo(self.ticketInfoContainer)
        })
        
        
        self.avatarNameLabel.snp.remakeConstraints({ make in
            make.left.equalTo(self).offset(padding)
            make.bottom.equalTo(self).inset(padding)
            make.width.equalTo(self).multipliedBy(0.4)
        })
        
    }
    
    
    
}
