//
//  UILabelExtension.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 15/12/20.
//

import Foundation
import UIKit

extension UILabel {

    func highlight(searchedText: String?..., color: UIColor = .red) {
        guard let txtLabel = self.text else { return }

        let attributeTxt = NSMutableAttributedString(string: txtLabel)

        searchedText.forEach {
            if let searchedText = $0?.lowercased() {
                let range: NSRange = attributeTxt.mutableString.range(of: searchedText, options: .caseInsensitive)

                attributeTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                attributeTxt.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: range)
            }
        }

        self.attributedText = attributeTxt
    }

}
