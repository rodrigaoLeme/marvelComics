//
//  ComicExtension.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 09/12/20.
//

import Foundation

extension Comic {
    
    var object:[String:Any]{
        return [
            "id": self.id!,
            "title":self.title!,
            "description":self.description ?? "",
            "thumbnail":["path": self.thumbnail?.path,"type":self.thumbnail?.type]
        ]
    }
}
