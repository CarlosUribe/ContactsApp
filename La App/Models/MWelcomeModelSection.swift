//
//  MWelcomeModelSection.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts
//MODEL THAT CREATES THE HEADER CELL(THE CELL WITH THE CAPITAL LETTER) OR COMMON CELL (WHERE CONTACT NAME AND PHONE ARE DIPLAYED)
class MWelcomeModelSection{
    let identifier:String
    let height:CGFloat
    let width:CGFloat
    let title:String
    let contact:CNContact?

    init(identifier: String, height: CGFloat, width: CGFloat, title: String, contact: CNContact?){
        self.identifier = identifier
        self.height = height
        self.width = width
        self.title = title
        self.contact = contact
    }

    class func header(title: String) -> MWelcomeModelSection{
        let header:MWelcomeModelSection = MWelcomeModelSectionHeader(title:title)
        return header
    }

    class func common(contact:CNContact) -> MWelcomeModelSection{
        let header:MWelcomeModelSection = MWelcomeModelSectionCommon(contact:contact)
        return header
    }
}
