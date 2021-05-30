//
//  CoreDataManger.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//

import UIKit
import CoreData

let PhotosEntitiy = "FlickrPhotos"

class CoreDataManager: NSObject {
    
    var photosDB: [NSManagedObject] = []
    static let  sharedInstance = CoreDataManager()
    
    func save(model:Photo) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: PhotosEntitiy, in: managedContext)!
        let moviePhoto = NSManagedObject(entity: entity, insertInto: managedContext) as! FlickrPhotos

        moviePhoto.farm = Int16(model.farm)
        moviePhoto.id = model.id
        moviePhoto.secret = model.secret
        moviePhoto.server = model.server
        moviePhoto.title = model.title
        moviePhoto.imageURL = model.imageURL
        moviePhoto.owner = model.owner
     
        do {
            try managedContext.save()
            photosDB.append(moviePhoto)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getPhotos(offset:Int = 0) -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return []
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: PhotosEntitiy)

        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = offset
        
        do {
            photosDB = try managedContext.fetch(fetchRequest)
            return photosDB
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    
}

