//
//  MWelcomeModel.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation
import Contacts

//FUNCTION TO GET CONTACTS FROM USER CELLPHONE, WILL RETURN THE SELECTED KEYS TO IMPLEMENT MORE FUNCTIONALITY WE SHOULD ADD KEYS
//IT WILL RETURN AN EMPTY ARRAY IF NO CONTACTS ARE FOUND
class MWelcomeModel{
    var contacts: [CNContact] = []

    init(){
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactImageDataKey,
            CNContactThumbnailImageDataKey] as [Any]

        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print(NSLocalizedString("Error_fetching_contacts", comment: ""))
        }

        var results: [CNContact] = []

        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print(NSLocalizedString("Error_fetching_contacts", comment: ""))
            }
        }

        contacts = results
    }
}
