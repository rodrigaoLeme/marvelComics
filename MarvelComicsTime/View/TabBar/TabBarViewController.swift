//
//  TabBarViewController.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 22/11/20.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        if ApplicationService.isDarkMode(){
            self.tabBar.unselectedItemTintColor = UIColor.lightGray
            self.tabBar.barTintColor = UIColor.black
            self.tabBar.tintColor = UIColor.white
        }
        
        initTopBarRightButton()
    }
    
    @objc public func userTapped() {
        if let accountDetail = UIStoryboard(name: "Account", bundle: nil).instantiateInitialViewController() as? AccountViewController {
            self.navigationController!.pushViewController(accountDetail, animated: true)
            //present(accountDetail, animated: true, completion: nil)
        }
    }
    
    func initTopBarRightButton(){
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action:#selector(userTapped))
        if ApplicationService.isDarkMode(){
            barButtonItem.tintColor = UIColor.white
        }
        self.navigationItem.rightBarButtonItem = barButtonItem
    }

}
