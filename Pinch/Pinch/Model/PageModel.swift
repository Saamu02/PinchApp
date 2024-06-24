//
//  PageModel.swift
//  Pinch
//
//  Created by Ussama Irfan on 24/06/2024.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String 
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
