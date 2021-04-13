//
//  HQ.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 23/11/20.
//

import Foundation
import RealmSwift
import Firebase

class Comic : Decodable {
    var id: Int?
    var title:String?
    var description:String?
    var pageCount:Int?
    var thumbnail:Image?
    var series:SeriesSummary?
    var variants:[ComicSummary]?
    var collections:[ComicSummary]?
    var collectedIssues:[ComicSummary]?
    //var dates:[ComicDate]?
    var prices:[ComicPrice]?
    var creators:CreatorList?
    var characters:CharacterList?
    
    init(id: Int?, title: String?, description: String?) {
        self.id = id
        self.title = title
        self.description = description
    }
    
    init(snapshot:DataSnapshot){
        self.id =  snapshot.childSnapshot(forPath: "id").value as? Int
        self.title = snapshot.childSnapshot(forPath: "title").value as? String
        self.description = snapshot.childSnapshot(forPath: "description").value as? String
        self.thumbnail = Image(snapshot:snapshot.childSnapshot(forPath: "thumbnail"))
        
    }

}

class ComicList:Decodable {
    var available:Int?
    var returned:Int?
    var collectionURI:String?
    var items:[ComicSummary]?
}

class ComicSummary :Decodable{
    var resourceURI :String?
    var name:String?
}

class ComicDate:Decodable {
    var type:String?
    var date:Date?
}

class ComicPrice:Decodable{
    var type:String?
    var price:Double
}
