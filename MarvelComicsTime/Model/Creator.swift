//
//  Creator.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 07/12/20.
//

import Foundation
class CreatorList: Decodable {
    var available:Int?
    var returned:Int?
    var collectionURI:String?
    var items : [CreatorSummary]?
}

class CreatorSummary: Decodable {
    var resourceURI:String?
    var name:String?
    var role:String?
}
