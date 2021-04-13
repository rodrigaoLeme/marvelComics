//
//  MarvelApiResponse.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation


class MarvelDataComicContainer:Decodable {
    var offset:Int?
    var limit:Int?
    var total :Int?
    var count :Int?
    var results:[Comic]?
}

class MarvelApiComicResponse:Decodable {
    var code: Int?
    var status:String?
    var copyright:String?
    var data:MarvelDataComicContainer?
}

class MarvelDataCharacterContainer:Decodable {
    var offset:Int?
    var limit:Int?
    var total :Int?
    var count :Int?
    var results:[Character]?
}

class MarvelApiCharacterResponse:Decodable {
    var code: Int?
    var status:String?
    var copyright:String?
    var data:MarvelDataCharacterContainer?
}






