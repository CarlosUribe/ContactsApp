//
//  CMainControllerTransitionPresent.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class CMainControllerTransitionPresent:CMainControllerTransition{
    override func startTransition(main:CMain){
        let mainRect:CGRect = main.view.bounds
        controller.view.frame = mainRect
        controller.view.alpha = 0
        main.addChild(controller)
        main.view.addSubview(controller.view)
        controller.didMove(toParent:main)
        controller.view.frame = main.view.bounds
        controller.didMove(toParent:main)

        UIView.animate(withDuration:main.interaction.kMoveControllerDuration, animations:
            {
                self.controller.view.alpha = 1
        })
        { (done) in

            super.startTransition(main:main)
        }
    }

    override func pop(){
        UIView.animate(withDuration:main.interaction.kMoveControllerDuration, animations:
            {
                self.controller.view.alpha = 0
        })
        { (done) in

            self.controller.willMove(toParent:nil)
            self.controller.view.removeFromSuperview()
            self.controller.removeFromParent()

            super.pop()
        }
    }
}
