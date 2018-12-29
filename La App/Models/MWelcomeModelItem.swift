//
//  MWelcomeModelItem.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation
import Contacts

//MODEL TO CREATE AN ARRAY THAT WILL HAVE ALL THE CONTACTS AND HEADERS FOR THE COLLECTIONVIEW DATASOURCE
//WILL FILTER FROM THE BEGINING ALL CONTACTS THAT DO NOT HAVE GIVEN NAME OR FAMILY NAME, WE CAN FILTER MORE IF NECESSARY


class MWelcomeModelItem{
    var contactIndex:[MWelcomeModelSection] = []

    init(contacts:[CNContact]){
        var contactsTmp:[CNContact] = contacts
        contactsTmp = contactsTmp.filter({$0.givenName != "" && $0.familyName != ""})
        let tmpArray:[CNContact] = contactsTmp.sorted(by: {$0.givenName < $1.givenName})
        let title:Character = tmpArray[0].givenName.first ?? " "
        var initialTitle:String = String(title)
        let firstHeader:MWelcomeModelSection = MWelcomeModelSection.header(title: initialTitle.uppercased())
        contactIndex.append(firstHeader)

        for contact in tmpArray{
            let title:Character = contact.givenName.first ?? " "
            let nextTitle:String = String(title)
            if  nextTitle != initialTitle{
                let nextHeader:MWelcomeModelSection = MWelcomeModelSection.header(title: nextTitle.uppercased())
                contactIndex.append(nextHeader)
                initialTitle = nextTitle
            }

            let commonContact:MWelcomeModelSection = MWelcomeModelSection.common(contact: contact)
            contactIndex.append(commonContact)
        }

        let contactIndexTmp = contactIndex
        for common in contactIndexTmp.reversed(){
            if common.identifier == VWelcomeCellView.reusableIdentifier(){
                if let contact = common.contact{
                    if CDBaseController.shared.isObjectOnDB(data: contact){
                        contactIndex = contactIndex.filter({$0.contact != contact})
                        contactIndex.insert(common, at: contactIndex.startIndex)
                    }
                }
            }
        }
    }
}
