//
//  FirebaseMarvelComicsService.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 12/12/20.
//

import Foundation
import Firebase

class FirebaseMarvelComicService {
    
    let comicsRef: DatabaseReference!
    
    let charactersRef: DatabaseReference!
    
    init() {
        let database = Database.database()
        self.comicsRef = database.reference(withPath: "comics")
        self.comicsRef.keepSynced(true)
        
        self.charactersRef = database.reference(withPath: "characters")
        self.charactersRef.keepSynced(true)
    }
    
    func searchComics(q:String?,completion: @escaping (_ json:  [Comic]?, _ error: String?) -> Void){
        var comics:[Comic] = []
        if let query = q {
            
            comicsRef.queryOrdered(byChild: "title").observe(.value, with: { (snapshot) -> Void in
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    comics = snapshots.map { (data:DataSnapshot) -> Comic in
                        return Comic(snapshot: data)
                    }.filter({ (comic:Comic) -> Bool in
                        return comic.title!.contains("\(query)")
                    })
                }
                
                completion(comics,nil)
                
            })
            
        }else{
            comicsRef.queryOrdered(byChild: "title").observe(.value, with: { (snapshot) -> Void in
                
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    comics = snapshots.map { (data:DataSnapshot) -> Comic in
                        return Comic(snapshot: data)
                    }
                }
                
                completion(comics,nil)
                
            })
        }
        
    }
    
    func containsComic(id:Int,completion: @escaping (_ json:  Bool, _ error: String?) -> Void){
        comicsRef.child("\(id)").observe(.value) { (snapshot) in
            completion(snapshot.exists(),nil)
        }
    }
    
    func saveComic(comic: Comic){
        comicsRef.child("\(comic.id!)").setValue(comic.object)
    }
    
    func deleteComic(id: Int){
        comicsRef.child("\(id)").removeValue()
    }
    
    func searchCharacter(completion: @escaping (_ json:  [Character]?, _ error: String?) -> Void){
        var characters:[Character] = []
        
        charactersRef.queryOrdered(byChild: "name").observe(.value, with: { (snapshot) -> Void in
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                characters = snapshots.map { (data:DataSnapshot) -> Character in
                    return Character(snapshot: data)
                }
            }
            
            completion(characters,nil)
        })
    }
    
    func containsCharacter(id:Int,completion: @escaping (_ json:  Bool, _ error: String?) -> Void){
        charactersRef.child("\(id)").observe(.value) { (snapshot) in
            completion(snapshot.exists(),nil)
        }
    }
    
    func saveCharacter(character: Character){
        charactersRef.child("\(character.id!)").setValue(character.object)
    }
    
    func deleteCharacter(id: Int){
        charactersRef.child("\(id)").removeValue()
    }
    
    static func isLogged() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    static func getUser() -> User{
        return Auth.auth().currentUser!
    }

}
