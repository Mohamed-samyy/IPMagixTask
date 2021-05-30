//
//  FlickrResponse.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//

import UIKit

struct FlickrResponseModel : Codable {
        let photos : Photos?
        let stat : String?
}

struct Photos : Codable {
    let page : Int?
    let pages : Int?
    let perpage : Int?
    let total : Int?
    let photo : [Photo]?
}
