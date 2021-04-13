//
//  CharacterCollectionViewCell.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 09/12/20.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    static let identifier = "CharacterCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CharacterCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.characterImageView.layer.cornerRadius = (characterImageView.frame.size.height)/2
        self.characterImageView.clipsToBounds = true
    }
    
    func setup(name:String?,image:String) {
        characterNameLabel.text = name
        if !image.isEmpty {
            characterImageView.setImage(with: image)
        }
    }

}
