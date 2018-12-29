//
//  ExtensionCollectionView.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

extension UICollectionReusableView{
    class func reusableIdentifier() -> String{
        let classType:AnyClass = object_getClass(self)!

        return NSStringFromClass(classType)
    }
}
