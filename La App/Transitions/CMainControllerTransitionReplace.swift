//
//  CMainControllerTransitionReplace.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class  CMainControllerTransitionReplace:CMainControllerTransition{
    override func startTransition(main:CMain){
        main.addChild(controller)
        main.view.addSubview(controller.view)
        controller.view.frame = main.view.bounds
        controller.didMove(toParent:main)

        super.startTransition(main:main)

        popAllPrevious()
        previousTransition = nil
    }
}
