//
//  CoreDataManger.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//

import UIKit
import CoreData


class CoreDataManager: NSObject {
    
    var photosDB: [NSManagedObject] = []
    static let  sharedInstance = CoreDataManager()
    
    func save(model:Photo) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MoviePhotos", in: managedContext)!
        let moviePhoto = NSManagedObject(entity: entity, insertInto: managedContext) as! MoviePhotos

        moviePhoto.farm = model.farm
        moviePhoto.id = model.id
        moviePhoto.secret = model.secret
        moviePhoto.server = model.server
        moviePhoto.title = model.title
        moviePhoto.owner = model.owner
        moviePhoto.isfamily = model.isfamily
        moviePhoto.isfriend = model.isfriend
        moviePhoto.ispublic = model.ispublic



     
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MoviePhotos")

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

