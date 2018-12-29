//
//  CFullContactInfoController.swift
//  La App
//
//  Created by Carlos Uribe on 12/29/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts
//FULL CONTACT CONTROLLER
class CFullContactInfoController: UIViewController{
    weak var fullView:VFullContactInfoView!
    var model: CNContact!

    convenience init(model:CNContact){
        self.init()
        self.model = model
    }

    override var preferredStatusBarStyle:UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override var prefersStatusBarHidden:Bool{
        return false
    }

    override func loadView() {
        let fullView: VFullContactInfoView = VFullContactInfoView(controller: self)
        view = fullView
    }
}
