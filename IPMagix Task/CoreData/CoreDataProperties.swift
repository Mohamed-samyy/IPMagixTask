//
//  CoreDataProperties.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//


import Foundation
import CoreData


extension MoviePhotos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviePhotos> {
        return NSFetchRequest<MoviePhotos>(entityName: "MoviePhotos")
    }

    @NSManaged public var farm: Int
    @NSManaged public var server: String?
    @NSManaged public var id: String?
    @NSManaged public var secret: String?
    @NSManaged public var owner: String?
    @NSManaged public var title: String?
    @NSManaged public var ispublic: Int
    @NSManaged public var isfriend: Int
    @NSManaged public var isfamily: Int

}
