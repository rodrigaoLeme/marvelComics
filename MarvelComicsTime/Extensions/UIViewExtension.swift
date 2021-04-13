//
//  UIViewExtension.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 14/12/20.
//

import Foundation
import UIKit

extension UIView {
    
    func pin(safeAarea: UILayoutGuide)  {
        searchHistoryTableViewController.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchHistoryTableViewController.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchHistoryTableViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchHistoryTableViewController.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
