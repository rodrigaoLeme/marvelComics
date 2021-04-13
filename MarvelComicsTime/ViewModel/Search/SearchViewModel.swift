//
//  SearchViewModel.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation

enum LibraryScope:Int {
    case external = 0
    case local = 1
}

class SearchViewModel {
    
    private var marvelComicService: MarvelComicService!
    private var firebaseMarvelComicService:FirebaseMarvelComicService!
    private var memoryDataSourceManager: MemoryDataSourceManager!
    
    private(set) var comics : [Comic]!
    
    init() {
        
        self.marvelComicService = MarvelComicService()
        self.firebaseMarvelComicService = FirebaseMarvelComicService()
        self.memoryDataSourceManager = MemoryDataSourceManager()
        
        self.comics = []
    }
    
    func search(q:String,scope:LibraryScope,completion: @escaping (_ loaded:  Bool) -> Void){
        switch scope {
        case LibraryScope.external:
            searchExternalComics(q: q){ loaded in
                completion(true)
            }
            
        case LibraryScope.local:
            searchLocalComics(q: q) {loaded in
                completion(true)
            }
        }
    }
    
    func saveSearch(search:String){
        memoryDataSourceManager.saveSearchHistory(search: search)
    }
    
    func clearSearch(){
        self.comics = []
    }
    
    fileprivate func searchLocalComics(q:String,completion: @escaping (_ loaded:  Bool) -> Void){
        self.firebaseMarvelComicService.searchComics(q: q){ (comics, error) in
            if let comics = comics{
                self.comics = comics
                completion(true)
            }
        }
    }
    
    fileprivate func searchExternalComics(q:String,completion: @escaping (_ loaded:  Bool) -> Void){
        self.marvelComicService.searchComics(q: q,characters: []){ (comics,error) in
            if let comics = comics{
                self.comics = comics
                completion(true)
            }
        }
    }
}
