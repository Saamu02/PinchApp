//
//  UIScreen+Extension.swift
//  Pinch
//
//  Created by Ussama Irfan on 21/06/2024.
//

import SwiftUI

extension UIScreen {
    
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

