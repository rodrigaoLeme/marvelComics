//
//  searchHistoryTableViewDataSource.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 14/12/20.
//

import Foundation
import UIKit
class SearchHistoryTableViewDataSource: UITableViewController {
    
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Q1")
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Q2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row]
        return cell
    }
}
