//
//  CMainControllerTransition.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class CMainControllerTransition{
    enum CMainControllerTransitionPoptype{
        case all
        case current
        case none
    }

    weak var main:CMain!
    var controller:UIViewController!
    var previousTransition:CMainControllerTransition?

    class func pushRight(controller:UIViewController, poptype:CMainControllerTransitionPoptype) -> CMainControllerTransitionPushRight{
        let transition:CMainControllerTransitionPushRight = CMainControllerTransitionPushRight(controller:controller, poptype:poptype)

        return transition
    }

    class func present(controller:UIViewController) -> CMainControllerTransitionPresent{
        let transition:CMainControllerTransitionPresent = CMainControllerTransitionPresent(controller:controller)

        return transition
    }

    class func replace(controller:UIViewController) -> CMainControllerTransitionReplace{
        let transition:CMainControllerTransitionReplace = CMainControllerTransitionReplace(controller:controller)

        return transition
    }

    init(controller:UIViewController){
        self.controller = controller
    }

    //MARK: public
    func popAllPrevious(){
        previousTransition?.popAllPrevious()
        previousTransition?.popNoAnimation()
        previousTransition = nil
    }

    func popCurrentPrevious(){
        previousTransition?.popNoAnimation()
        previousTransition = previousTransition?.previousTransition
    }

    func popNoAnimation(){
        controller?.view.removeFromSuperview()
        controller?.removeFromParent()
        controller?.didMove(toParent:nil)
    }

    func startTransition(main:CMain){
        self.main = main
        previousTransition = main.transition
        main.transition = self
    }

    func pop(){
        main.transition = previousTransition
        popNoAnimation()
    }
}
