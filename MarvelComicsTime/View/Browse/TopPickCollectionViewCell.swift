//
//  TopPickCollectionViewCell.swift
//  MarvelComicsTime
//
//  Created by Rodrigo Leme on 07/12/20.
//

import UIKit
import Kingfisher

class TopPickCollectionViewCell: UICollectionViewCell {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var imageViewComic: UIImageView!
    
    public func configure(with comic: Comic) {
        labelTitle.text = ""
        labelDescription.text = ""
        
        labelTitle.text = comic.title!
        if let description = comic.description {
            labelDescription.text = description
        }
        
        if let image = comic.thumbnail{
            if let path = image.path{
                imageViewComic.setImage(with: "\(path).\(image.type!)")
            }
           
        }
    }
    
    
}
