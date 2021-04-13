//
//  CharacterDetailViewModel.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 07/12/20.
//

import Foundation

enum UrlType:String {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

class CharacterDetailViewModel {
    
    private var firebaseMarvelComicService:FirebaseMarvelComicService!
    
    private var character:Character!
    
    var name: String? = ""
    var image: String?
    var description:String? = ""
    var datailUrl:String? = ""
    var wikiUrl:String? = ""
    var comiclink:String? = ""
    var isFavorite:Bool = false
    
    init(character:Character) {
        self.firebaseMarvelComicService = FirebaseMarvelComicService()
        
        self.character = character
        self.name = character.name
        if let image = character.thumbnail {
            self.image = "\(image.path!).\(image.type!)"
        }
        self.description = character.description
        
        character.urls?.forEach({ (url:Url) in
            if url.type == UrlType.detail.rawValue {
                self.datailUrl = url.url
            }else if url.type == UrlType.comiclink.rawValue{
                self.comiclink = url.url
            }else if url.type == UrlType.wiki.rawValue{
                self.wikiUrl = url.url
            }
        })
        
    }
    
    func isFavorite(completion: @escaping (_ isOnLocalDatabase:  Bool) -> Void){
        firebaseMarvelComicService.containsCharacter(id: self.character.id!) { (onLocal,error) in
            self.isFavorite = onLocal
           completion(onLocal)
        }
    }
    
    func favoriteCharacter(){
        firebaseMarvelComicService.saveCharacter(character: self.character)
    }
    
    func deleteCharacter() {
        firebaseMarvelComicService.deleteCharacter(id: self.character.id!)
    }
    
}
