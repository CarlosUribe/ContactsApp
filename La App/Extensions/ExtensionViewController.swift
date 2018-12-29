//
//  ExtensionViewController.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

//Extension to provide parent controller
extension UIViewController{
    var parentController:CMain{
        get{
            return self.parent as! CMain
        }
    }
}
