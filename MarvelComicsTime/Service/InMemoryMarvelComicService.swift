//
//  InMemoryMarvelComicService.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation
import RealmSwift

class InMemoryMarvelComicService {
    
    
    func search(q:String?,completion: @escaping (_ json:  [Comic]?, _ error: String?) -> Void){
        var localComics :Results<ComicDB>
        let realm = try! Realm()
        
        if let query = q {
            localComics = realm.objects(ComicDB.self).filter("title CONTAINS '\(query)'")
        }else{
            localComics = realm.objects(ComicDB.self)
        }
        
        let comics =  Array(localComics).map { (comicDB:ComicDB) -> Comic in
            return Comic(comicDB:comicDB)
        }
        
        completion(comics,nil)
    }
    
    func saveComic(comic: Comic){
        let realm = try! Realm()
        
        let comicDB = comic.db
        
        try! realm.write {
            realm.add(comicDB)
        }
    }
    
    func containsComic(id:Int) -> Bool{
        let realm = try! Realm()
        let comics = realm.objects(ComicDB.self).filter("id == \(id)")
        return comics.count > 0
    }
    
    func deleteComic(id: Int){
        let realm = try! Realm()
        
        let comic = realm.objects(ComicDB.self).filter("id == \(id)")
        
        try! realm.write {
            realm.delete(comic)
        }
        
        
    }
    
}
