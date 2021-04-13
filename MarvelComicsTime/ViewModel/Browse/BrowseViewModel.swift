//
//  HomeViewModel.swift
//  MarvelComicsTime
//
//  Created by Rodrigo Leme on 09/12/20.
//

import Foundation

class BrowseViewModel {
    private var marvelComicService: MarvelComicService!
    private var firebaseMarvelComicService:FirebaseMarvelComicService!
    
    private(set) var comics : [Comic]!
    private(set) var recentlyAddedComics : [Comic]!
    private(set) var characters : [Character]!
    
    init() {
        self.marvelComicService = MarvelComicService()
        self.firebaseMarvelComicService = FirebaseMarvelComicService()
        
        comics = []
        recentlyAddedComics = []
        characters = []
    }
    
    func getComicCharacters(completion: @escaping (_ loaded:  Bool) -> Void){
        firebaseMarvelComicService.searchCharacter(completion: { (characters, error) in
            if let characters = characters{
                self.characters = characters
                completion(true)
            }
        })
    }
    
    func getComicsList(completion: @escaping (_ loaded:  Bool) -> Void){
        
        let charactersIds = self.characters.map { (character:Character) -> Int in
            return character.id!
        }
        
        marvelComicService.searchComics(q: "",characters:charactersIds) { (comics, error) in
            if let comics = comics {
                self.comics = comics
            }
            completion(true)
        }
    }
    
    func getLocalComicsList(completion: @escaping (_ loaded:  Bool) -> Void){
        firebaseMarvelComicService.searchComics(q: nil){(comics,error) in
            if let comics = comics{
                self.recentlyAddedComics = comics
                completion(true)
            }
        }
    }
    
    func getComics() -> [Comic] {
        return comics
    }

}
