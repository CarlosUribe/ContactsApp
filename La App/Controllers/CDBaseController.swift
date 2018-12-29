//
//  CDBaseController.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import CoreData
import Contacts
//SINGLETON TO MANAGE DB ACCESS DELETE IMPLEMENTED BUT NOT IN USE 
class CDBaseController{
    static let shared:CDBaseController = CDBaseController()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
    private init(){
    }
    func saveData(data: CNContact){
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let newContact = NSManagedObject(entity: entity!, insertInto: context)

        newContact.setValue(data.givenName, forKey: "name")
        newContact.setValue(data.phoneNumbers, forKey: "phone")

        do {
            try context.save()
        } catch {
            print(NSLocalizedString("CDBaseController_Failed_Save", comment: ""))
        }
    }

    func deleteData(data: CNContact) -> Bool{
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for objects in result as! [NSManagedObject] {
                if objects.value(forKey: "phone") as! [CNLabeledValue<CNPhoneNumber>] == data.phoneNumbers{
                    context.delete(objects)
                    try context.save()
                    return true
                }
            }
        } catch {
            return false
        }

        return false
    }

    func isObjectOnDB(data: CNContact) -> Bool{
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for objects in result as! [NSManagedObject] {
                if objects.value(forKey: "phone") as! [CNLabeledValue<CNPhoneNumber>] == data.phoneNumbers{
                    return true
                }
            }

        } catch {
            return false
        }

        return false
    }
}
