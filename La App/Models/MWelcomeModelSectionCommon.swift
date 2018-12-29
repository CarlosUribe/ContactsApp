//
//  MWelcomeModelSectionCommon.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts
//COMMON CELL FOR SHOWING CONTACT DATA
class MWelcomeModelSectionCommon: MWelcomeModelSection{
    private let kConstantHeightForCommonCell: CGFloat = 70

    init(contact:CNContact){
        let reusableIdentifier: String = VWelcomeCellView.reusableIdentifier()
        let width: CGFloat = UIScreen.main.bounds.width - 10

        super.init(identifier: reusableIdentifier, height: kConstantHeightForCommonCell, width: width, title: "", contact: contact)
    }
}

