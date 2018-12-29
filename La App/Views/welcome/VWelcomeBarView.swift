//
//  VWelcomeBarView.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VWelcomeBarView:UIView{
    weak var controller:CWelcomeController!

    convenience init(controller:CWelcomeController){
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true
        isUserInteractionEnabled = false

        self.controller = controller

        let labelTitle:UILabel = UILabel()
        labelTitle.clipsToBounds = true
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        labelTitle.textColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0)
        labelTitle.text = NSLocalizedString("VWelcomeBarView_title", comment: "")

        addSubview(labelTitle)

        let views:[String : Any] = [
            "label":labelTitle]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-34-[label(20)]",
            options:[],
            metrics:metrics,
            views:views))
    }
}
