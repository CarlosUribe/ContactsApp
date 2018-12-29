//
//  MWelcomeModelSectionHeader.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
//HEADER CELL FOR SORT 
class MWelcomeModelSectionHeader: MWelcomeModelSection{
    private let kConstantHeightForHeaderCell: CGFloat = 50

    init(title:String){
        let reusableIdentifier: String = VWelcomeHeaderCellView.reusableIdentifier()
        let width: CGFloat = UIScreen.main.bounds.width - 10

        super.init(identifier: reusableIdentifier, height: kConstantHeightForHeaderCell, width: width, title: title, contact: nil)
    }
}

