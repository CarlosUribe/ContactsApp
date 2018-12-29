//
//  VWelcomeCellView.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts

class VWelcomeCellView: VWelcomeBaseCell{
    weak var nameContact:UILabel!
    weak var phoneNumber:UILabel!
    weak var avatar:UIImageView!
    weak var model:CNContact!
    weak var avatarLabel:UILabel!
    private let kConstantHeightAvatar: CGFloat = 30

    override init(frame:CGRect){
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        let separator:UIView = UIView()
        separator.clipsToBounds = true
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.94, alpha:0.8)

        let nameContact:UILabel = UILabel()
        nameContact.clipsToBounds = true
        nameContact.translatesAutoresizingMaskIntoConstraints = false
        nameContact.numberOfLines = 0
        nameContact.textAlignment = .left
        nameContact.font = UIFont.systemFont(ofSize: 16, weight: .black)
        nameContact.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        self.nameContact = nameContact

        let avatar:UIImageView = UIImageView()
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = kConstantHeightAvatar
        self.avatar = avatar

        let avatarLabel:UILabel = UILabel()
        avatarLabel.clipsToBounds = true
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarLabel.layer.cornerRadius = kConstantHeightAvatar
        avatarLabel.textAlignment = .center
        avatarLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        avatarLabel.backgroundColor = UIColor(red:0.87, green:0.83, blue:0.83, alpha:1.0)
        avatarLabel.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        self.avatarLabel = avatarLabel

        let phoneNumber:UILabel = UILabel()
        phoneNumber.clipsToBounds = true
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.numberOfLines = 0
        phoneNumber.textAlignment = .left
        phoneNumber.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        phoneNumber.textColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0)
        self.phoneNumber = phoneNumber

        addSubview(nameContact)
        addSubview(avatar)
        addSubview(avatarLabel)
        addSubview(phoneNumber)
        addSubview(separator)

        let views:[String : Any] = [
            "name":nameContact,
            "avatar":avatar,
            "avatarLabel":avatarLabel,
            "phone":phoneNumber,
            "separator":separator]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[avatar(60)]-10-[name]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[avatarLabel(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-80-[phone]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-5-[name(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[avatar(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[avatarLabel(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[name]-0-[phone]-5-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-80-[separator]-5-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[separator(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func config(model:CNContact?){
        if model != nil{
            self.model = model

            self.nameContact.text = model?.givenName
            if let thumbnailData: Data = model?.thumbnailImageData{
                avatar.isHidden = false
                avatarLabel.isHidden = true
                self.avatar.image = UIImage.init(data: thumbnailData)
            }else{
                avatar.isHidden = true
                avatarLabel.isHidden = false
                let first:String = String(model?.givenName.first ?? " ")
                let second:String = String(model?.familyName.first ?? " ")
                let nick:String = "\(first.uppercased())\(second.uppercased())"
                avatarLabel.text = nick
            }

            var phoneString: String = ""
            for phone in model?.phoneNumbers ?? []{
                phoneString += "\(phone.value.stringValue)\n"
            }
            self.phoneNumber.text = phoneString
        }else{
            //TODO: WHAT HAPPENS WHEN MODEL IS NIL
        }
    }
}
