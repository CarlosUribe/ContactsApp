//
//  VWelcomeBaseCell.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts

class VWelcomeBaseCell: UICollectionViewCell {
    override init(frame:CGRect){
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(model: CNContact?){}
    func configHeader(title: String){}
}
