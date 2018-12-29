//
//  VWelcomeHeaderCellView.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VWelcomeHeaderCellView: VWelcomeBaseCell{
    weak var titleHeader:UILabel!

    override init(frame:CGRect){
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red:0.98, green:0.89, blue:0.89, alpha:1.0)

        let titleHeader:UILabel = UILabel()
        titleHeader.clipsToBounds = true
        titleHeader.translatesAutoresizingMaskIntoConstraints = false
        titleHeader.numberOfLines = 0
        titleHeader.textAlignment = .left
        titleHeader.font = UIFont.systemFont(ofSize: 16, weight: .black)
        titleHeader.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        self.titleHeader = titleHeader

        addSubview(titleHeader)

        let views:[String : Any] = [
            "title":titleHeader]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[title]-10-|",
            options:[],
            metrics:metrics,
            views:views))
           addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[title]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configHeader(title:String){
        self.titleHeader.text = title
    }
}

