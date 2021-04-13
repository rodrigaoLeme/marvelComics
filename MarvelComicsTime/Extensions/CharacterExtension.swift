//
//  CharacterExtension.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 13/12/20.
//

import Foundation
extension Character {
    
    var object:[String:Any]{
        return [
            "id": self.id!,
            "name":self.name!,
            "description":self.description!,
            "thumbnail":["path": self.thumbnail?.path,"type":self.thumbnail?.type]
        ]
    }
}
