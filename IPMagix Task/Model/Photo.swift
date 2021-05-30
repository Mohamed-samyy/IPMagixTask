//
//  FlickerPhoto.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/29/21.
//

import Foundation

struct Photo: Codable {
    var farm: Int = 0
    var server: String = ""
    var id: String = ""
    var secret: String = ""
    var owner : String = ""
    var title : String = ""
    var imageURL : String = ""
    var ispublic : Int = 0
    var isfriend : Int = 0
    var isfamily : Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case farm = "farm", server = "server", id = "id", secret = "secret", owner = "owner", title = "title",imageURL = "imageURL" ,ispublic = "ispublic", isfriend = "isfriend", isfamily = "isfamily"
    }
    init(farm: Int, id: String, server: String, secrect: String, owner: String, title: String, imageURL: String,ispublic: Int, isfriend: Int, isfamily: Int) {
        self.farm = farm
        self.id = id
        self.server = server
        self.owner = owner
        self.title = title
        self.imageURL = imageURL
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily

    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        farm = try container.decode(Int.self, forKey: .farm)
        server = try container.decode(String.self, forKey: .server)
        id = try container.decode(String.self, forKey: .id)
        secret = try container.decode(String.self, forKey: .secret)
        owner = try container.decode(String.self, forKey: .owner)
        title = try container.decode(String.self, forKey: .title)
        ispublic = try container.decode(Int.self, forKey: .ispublic)
        isfriend = try container.decode(Int.self, forKey: .isfriend)
        isfamily = try container.decode(Int.self, forKey: .isfamily)
//        CoreDataManager.sharedInstance.save(model: self)
        imageURL = createImageURL()

    }
    
    func createImageURL() -> String {
        return ("https://farm\(String(describing: farm)).staticflickr.com/\(String(describing: server))/\(String(describing: id))_\(String(describing: secret)).jpg")
    }
}

