//
//  CharacterCollectionViewCell.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 24/11/20.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewCharacter: UIImageView!
    @IBOutlet weak var labelNomeCharacter: UILabel!
    
    func setup(name:String?,image:String) {
        labelNomeCharacter.text = name
        if !image.isEmpty {
            imageViewCharacter.setImage(with: image)
        }
    }
}
