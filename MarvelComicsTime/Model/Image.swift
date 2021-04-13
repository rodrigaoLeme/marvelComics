//
//  Thumbnail.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 07/12/20.
//

import Foundation
import Firebase

class  Image: Codable {
    var path:String?
    var type:String?
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.path = try container.decode(String.self, forKey: .path)
      }
    
    init(snapshot:DataSnapshot) {
        self.path = snapshot.childSnapshot(forPath: "path").value as? String
        self.type = snapshot.childSnapshot(forPath: "type").value as? String
    }
    
    private enum Keys: String, CodingKey {
        case type = "extension"
        case path = "path"
      }
    
    
}
