//
//  PhotosViewModel.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/28/21.
//

import UIKit

class PhotosViewModel: NSObject {
    
    var viewTypes: [ViewType] = []
    var photos: [Photo]?
    
    func getApi(onSuccess: (() -> Void)) {
        photos?.enumerated().forEach { (index, photo) in
            if index % 5 == 0 && index != 0{
                viewTypes.append(.ad)
                viewTypes.append(.normalView(photo: photo))
            } else {
                viewTypes.append(.normalView(photo: photo))
            }
        }
        
        onSuccess()
        
    }
    
    func numberOfRowsInSection() -> Int {
        return viewTypes.count
    }
}
enum ViewType {
    case ad
    case normalView(photo: Photo)
}
