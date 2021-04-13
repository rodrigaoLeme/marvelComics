//
//  MemoryDatasourceManager.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation
import RealmSwift

class MemoryDataSourceManager {
    
    let realm = try! Realm()
    
    func saveSearchHistory(search:String){
        let history = realm.objects(SearchHistory.self).filter("search = '\(search)'").sorted(byKeyPath: "search")
        if(history.isEmpty){
            let searchHistory:SearchHistory = SearchHistory()
            searchHistory.search = search
            
            try! realm.write {
                realm.add(searchHistory)
            }
        }
    }
    
    func getSearchHistory(q:String?) -> [String] {
        
        var  history = realm.objects(SearchHistory.self).sorted(byKeyPath: "search")
        if let search = q {
            let historyFilter = realm.objects(SearchHistory.self).filter("search CONTAINS '\(search)'").sorted(byKeyPath: "search")
            
            if !historyFilter.isEmpty{
                history = historyFilter
            }
        }
        
        
       
        return Array(history).map { (search:SearchHistory) -> String in
            return search.search
        }
    }
    
}


