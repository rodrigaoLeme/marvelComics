//
//  StringExtension.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 06/12/20.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
