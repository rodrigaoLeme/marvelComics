//
//  MarvelComicService.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 06/12/20.
//

import Foundation

class MarvelComicService {
    
    let pubKey = "e41f3722540b3ba53518bbc6addeb89e"
    let pvtKey = "2be3a4ce06683ed731a5e92c1f9c4ba8f3c5234b"
    let baseUrl = "https://gateway.marvel.com:443/v1/public"
    
    var apiManeger = ApiManager ()
    
    func  getComic(id: Int) -> Comic {
        var comic:Comic!
        let url = buildServiceURL(url: "\(baseUrl)/comics/\(id)", hasParms: false)
        apiManeger.request(url: url) { (data, errorStr) in
            
            if data != nil {
                do {
                    let json = try JSONDecoder().decode(MarvelApiComicResponse.self, from: data!)
                    if let comicResult = json.data?.results?.first {
                        comic = comicResult
                    }
                } catch let error {
                    print(error)
                }
                
            }
        }
        return comic
    }
    
    func searchComics(q: String,characters:[Int], completion: @escaping (_ json:  [Comic]?, _ error: String?) -> Void){
        
        var url = "\(baseUrl)/comics"
        var hasParams = false
        
        if !q.isEmpty {
            hasParams = true
            url = "\(url)?titleStartsWith=\(q)"
        }
        
        if !characters.isEmpty {
            
            var ids:String = ""
            
            for item in characters {
                ids = ids + item.description + ","
            }
            
            ids = String(ids.dropLast())
           
            if hasParams {
                url = "\(url)&characters=\(ids)"
            }else{
                hasParams = true
                url = "\(url)?characters=\(ids)"
            }
           
        }
        
        url = buildServiceURL(url: url, hasParms: hasParams)
       
        apiManeger.request(url: url) { (data, errorStr) in
            
            if let data = data {
                
                do {
                    let json = try JSONDecoder().decode(MarvelApiComicResponse.self, from: data)
                    if let comicsResult = json.data?.results {
                        completion(comicsResult,nil)
                    }
                    
                } catch let error {
                    completion([],error.localizedDescription)
                }
                
            }
        }
        
    }
    
    func getCharacter(id: Int) -> Character {
        var  character:Character!
        
        let url = buildServiceURL(url: "\(baseUrl)/characters/\(id)", hasParms: false)
        apiManeger.request(url: url) { (data, errorStr) in
            if let data = data{
                do {
                    let json = try JSONDecoder().decode(MarvelApiCharacterResponse.self, from: data)
                    if let characterResult = json.data?.results?.first {
                        character = characterResult
                    }
                    
                } catch let error {
                    print(error)
                }
            }
        }
        return character
    }
    
    func getComicCharacters(id: Int, completion: @escaping (_ json:  [Character]?, _ error: String?) -> Void){
      
        let url = buildServiceURL(url: "\(baseUrl)/comics/\(id)/characters", hasParms: false)
        apiManeger.request(url: url) { (data, errorStr) in
            if let data = data{
                do {
                    let json = try JSONDecoder().decode(MarvelApiCharacterResponse.self, from: data)
                    if let characterResult = json.data?.results {
                        completion(characterResult,nil)
                    }
                    
                } catch let error {
                    completion(nil,error.localizedDescription)
                    
                }
            }
        }

    }
    
    private func buildServiceURL(url: String, hasParms: Bool) -> String {
        let ts = Date().timeIntervalSinceNow
        let hash = String(ts) + pvtKey + pubKey
        let symbol = hasParms ? "&" : "?"
        return "\(url)\(symbol)ts=\(ts)&apikey=\(pubKey)&hash=\(hash.md5)"
    }
}

