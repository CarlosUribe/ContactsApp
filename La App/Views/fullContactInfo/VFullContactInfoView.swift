//
//  VFullContactInfoView.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts
//FULL CONTACT VIEW TO DISPLAY INFO ABOUT THE CONTACT FOR THE MOMENT JUST DISPLAYS AVATAR NAME AND PHONE NUMBER 
class VFullContactInfoView:UIView{
    weak var controller: CFullContactInfoController!
    weak var bar: VFullContactInfoBarView!
    weak var nameContact:UILabel!
    weak var phoneNumber:UILabel!
    weak var model: CNContact!
    private let kConstantHeightAvatar: CGFloat = 50
    private let kBarHeight:CGFloat = 88.0

    convenience init(controller: CFullContactInfoController){
        self.init()
        self.controller = controller
        self.model = controller.model
        backgroundColor = .white
        
        let bar: VFullContactInfoBarView = VFullContactInfoBarView(controller: controller)
        self.bar = bar
        let givenName: String = model.givenName
        let familyName: String = model.familyName

        let nameContact:UILabel = UILabel()
        nameContact.clipsToBounds = true
        nameContact.translatesAutoresizingMaskIntoConstraints = false
        nameContact.numberOfLines = 0
        nameContact.textAlignment = .center
        nameContact.font = UIFont.systemFont(ofSize: 16, weight: .black)
        nameContact.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        nameContact.text = "\(givenName) \(familyName)"
        self.nameContact = nameContact

        let avatar:UIImageView = UIImageView()
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = kConstantHeightAvatar

        let avatarLabel:UILabel = UILabel()
        avatarLabel.clipsToBounds = true
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarLabel.layer.cornerRadius = kConstantHeightAvatar
        avatarLabel.textAlignment = .center
        avatarLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        avatarLabel.backgroundColor = UIColor(red:0.87, green:0.83, blue:0.83, alpha:1.0)
        avatarLabel.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)

        if model.imageDataAvailable{
            if let imageData = model.imageData{
                avatar.image = UIImage.init(data: imageData)
                avatar.isHidden = false
                avatarLabel.isHidden = true
            }else{
                avatar.isHidden = true
                avatarLabel.isHidden = false
                let first:String = String(givenName.first ?? " ")
                let second:String = String(familyName.first ?? " ")
                let nick:String = "\(first.uppercased())\(second.uppercased())"
                avatarLabel.text = nick
            }

        }else{
            avatar.isHidden = true
            avatarLabel.isHidden = false
            let first:String = String(givenName.first ?? " ")
            let second:String = String(familyName.first ?? " ")
            let nick:String = "\(first.uppercased())\(second.uppercased())"
            avatarLabel.text = nick
        }

        let phoneNumber:UILabel = UILabel()
        phoneNumber.clipsToBounds = true
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.numberOfLines = 0
        phoneNumber.textAlignment = .center
        phoneNumber.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        phoneNumber.textColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0)
        var phoneString: String = ""
        for phone in model.phoneNumbers{
            phoneString += "\(phone.value.stringValue)\n"
        }
        phoneNumber.text = phoneString
        self.phoneNumber = phoneNumber

        addSubview(nameContact)
        addSubview(avatar)
        addSubview(avatarLabel)
        addSubview(phoneNumber)
        addSubview(bar)

        let views:[String : Any] = [
            "bar":bar,
            "name":nameContact,
            "avatar":avatar,
            "avatarLabel":avatarLabel,
            "phone":phoneNumber]

        let avatarWidth: CGFloat = (UIScreen.main.bounds.width / 2) - 50

        let metrics:[String : CGFloat] = [
            "avatarWidth":avatarWidth,
            "barHeight":kBarHeight]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(avatarWidth)-[avatar(100)]-(avatarWidth)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(avatarWidth)-[avatarLabel(100)]-(avatarWidth)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[phone]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[name]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bar]-20-[avatar(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bar]-20-[avatarLabel(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[avatarLabel]-50-[name(30)]-0-[phone]",
            options:[],
            metrics:metrics,
            views:views))
    }
}
