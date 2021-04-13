//
//  AccountViewController.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 27/01/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var accountTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAccountTableView()
        registerCells()
    }
    
    @objc public func userTapped() {
        dismiss(animated: true, completion: nil)
    }
    
   
    
    func initAccountTableView(){
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        
        self.accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func registerCells(){
        accountTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    

}

extension AccountViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.navigationController?.popToRootViewController(animated: true)
            FirebaseMarvelComicService.logout()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Sign Out"
            cell.textLabel?.textColor = UIColor.systemBlue
            cell.backgroundColor = UIColor.secondarySystemGroupedBackground
            return cell
        } else if indexPath.row == 0 && FirebaseMarvelComicService.isLogged() {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
            let name = FirebaseMarvelComicService.getUser().displayName
            let email =  FirebaseMarvelComicService.getUser().email
            let image = FirebaseMarvelComicService.getUser().photoURL?.absoluteURL.absoluteString
            cell.configure(username:name,email: email,image: image)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
      
        
    }
    
    
}
