//
//  SearchHistoryTableViewController.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 14/12/20.
//

import UIKit

class SearchHistoryTableViewController: UITableViewController {
    
    var memoryDataSourceManager:MemoryDataSourceManager = MemoryDataSourceManager()
    var history:[String] = []
    var selected:String = ""
    var search = ""
    var didSelectItem: ((_ text: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        registerCells()
    }
    
    func setSearchText(text:String?) {
        if let text = text {
            self.search = text
        }
       
        history = self.memoryDataSourceManager.getSearchHistory(q: text)
        self.tableView.reloadData()
    }
    
    func initTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorInset = .init(top: 0, left: 25, bottom: 0, right: 0)
    }
    
    func registerCells(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(history[indexPath.row])
        self.selected = history[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.image =  UIImage(systemName: "magnifyingglass",withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        cell.imageView?.tintColor = UIColor.label
        cell.textLabel?.text = history[indexPath.row]
        cell.textLabel?.textColor =  UIColor.secondaryLabel
        cell.textLabel?.highlight(searchedText: search, color: UIColor.label)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
