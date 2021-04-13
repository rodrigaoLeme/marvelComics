//
//  RecentlyAddedCollectionViewCell.swift
//  MarvelComicsTime
//
//  Created by Rodrigo Leme on 21/01/21.
//

import UIKit

class RecentlyAddedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    
    public func configure(with comic: Comic) {
        labelTitle.text = ""
        
        labelTitle.text = comic.title!
        
        if let image = comic.thumbnail{
            if let path = image.path{
                imageView.setImage(with: "\(path).\(image.type!)")
            }
           
        }
    }
    
}
