//
//  CWelcomeController.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
//INITIAL WELCOME CONTROLLER 
class CWelcomeController: UIViewController{
    weak var controller: CMain!
    weak var welcomeView: VWelcomeView!
    var model: MWelcomeModelItem!

    convenience init(controller: CMain){
        self.init()
        self.controller = controller
        self.model = MWelcomeModelItem(contacts:MWelcomeModel().contacts)
    }

    override var preferredStatusBarStyle:UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override var prefersStatusBarHidden:Bool{
        return false
    }

    override func loadView() {
        let welcomeView: VWelcomeView = VWelcomeView(controller: self)
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
    }
}
