//
//  ComicDetailViewModel.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation
import UIKit

class ComicDetailViewModel  {
    
    private var marvelComicService: MarvelComicService!
    private var firebaseMarvelComicService:FirebaseMarvelComicService!
    
    private var comic: Comic!
    var title: String?
    var image: String?
    var description:String?
    var characters:[Character]!
    var isOnLocal = false
    
    init(comic:Comic) {
        self.marvelComicService = MarvelComicService()
        self.firebaseMarvelComicService = FirebaseMarvelComicService()
        
        self.comic = comic
        self.title = comic.title ?? ""
        self.description = comic.description ?? ""
        
        if let image = comic.thumbnail {
            if let path = image.path {
                self.image = "\(path).\(image.type!)"
            }
        }
        self .characters = []
    }
    
    func getComicCharacters(completion: @escaping (_ loaded:  Bool) -> Void){
        marvelComicService.getComicCharacters(id: self.comic.id!){(characters,error) in
            if let characters = characters{
                self.characters = characters
                completion(true)
            }
            
        }
        
    }
    
    func isComicOnLocalDatabase(completion: @escaping (_ isOnLocalDatabase:  Bool) -> Void){
        firebaseMarvelComicService.containsComic(id: self.comic.id!) { (onLocal,error) in
    self.isOnLocal = onLocal
           completion(onLocal)
        }
    }
    
    func saveComic(){
        firebaseMarvelComicService.saveComic(comic: self.comic)
    }
    
    func deleteComic() {
        firebaseMarvelComicService.deleteComic(id:  self.comic.id!)
    }
    
}

