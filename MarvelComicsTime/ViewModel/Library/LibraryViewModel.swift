//
//  LibraryViewModel.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation
class LibraryViewModel {
    private var marvelComicService: MarvelComicService!
    private var firebaseMarvelComicService:FirebaseMarvelComicService!
    
    private(set) var comics : [Comic]!
    
    init() {
        self.marvelComicService = MarvelComicService()
        self.firebaseMarvelComicService = FirebaseMarvelComicService()
        
        self.comics = []
    }
    
    func search(q:String?,completion: @escaping (_ loaded:  Bool) -> Void){
        self.firebaseMarvelComicService.searchComics(q: q){(comics,error) in
            if let comics = comics{
                self.comics = comics
                completion(true)
            }
        }
        
    }
    
    func clearSearch(){
        self.comics = []
    }
}
