//
//  ApplicationService.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 28/01/21.
//

import Foundation
import UIKit

class ApplicationService{
    
    
    static func isDarkMode() -> Bool{
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
}
