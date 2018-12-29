//
//  VFullContactInfoBarView.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VFullContactInfoBarView:UIView{
    weak var controller:CFullContactInfoController!

    convenience init(controller:CFullContactInfoController){
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true
        isUserInteractionEnabled = true

        self.controller = controller

        let separator:UIView = UIView()
        separator.clipsToBounds = true
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.94, alpha:0.8)

        let backButton:UIButton = UIButton()
        backButton.clipsToBounds = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitleColor(UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0), for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let labelTitle:UILabel = UILabel()
        labelTitle.clipsToBounds = true
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        labelTitle.textColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0)
        labelTitle.text = controller.model.givenName

        addSubview(labelTitle)
        addSubview(backButton)
        addSubview(separator)

        let views:[String : Any] = [
            "back":backButton,
            "label":labelTitle,
            "separator":separator]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-34-[label(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-15-[back(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-14-[back(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[separator]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[separator(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }

    //MARK: BUTTON ACTION

    @objc func goBack(){
        controller.parentController.pop()
    }
}

