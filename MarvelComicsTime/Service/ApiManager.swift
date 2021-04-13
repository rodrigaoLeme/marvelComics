//
//  ApiManager.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 06/12/20.
//

import Foundation
import Alamofire

class ApiManager {
    

    func request(url: String, completion: @escaping (_ json:  Data?, _ error: String?) -> Void)  {
        
        AF.request(url).responseJSON { response in
            
            switch response.result {
            case .failure(let error):
                completion(nil,error.errorDescription)
            case .success:
                if let data = response.data {
                    completion(data,nil)
                }
            }
        }
    }
}
