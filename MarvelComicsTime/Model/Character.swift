//
//  Character.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 23/11/20.
//

import Foundation
import Firebase

class Character:Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail:Image?
    var comics:ComicList?
    var urls:[Url]?
    
    init(id: Int, name: String, thumbnail: Image, description: String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
    
    init(snapshot:DataSnapshot){
        self.id =  snapshot.childSnapshot(forPath: "id").value as? Int
        self.name = snapshot.childSnapshot(forPath: "name").value as? String
        self.description = snapshot.childSnapshot(forPath: "description").value as? String
        self.thumbnail = Image(snapshot:snapshot.childSnapshot(forPath: "thumbnail"))
    }
}

class CharacterList:Decodable{
    var available:Int?
    var returned:Int?
    var collectionURI:String?
    var items:[CharacterSummary]?
}
 
class CharacterSummary:Decodable {
    var resourceURI:String?
    var name :String?
    var role :String?
}
