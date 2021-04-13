//
//  ComicTableViewCell.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 08/12/20.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "ComicTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ComicTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(comic: Comic) {
        titleLabel.text = comic.title
        descriptionLabel.text = comic.description
    
       if let image = comic.thumbnail{
            if let path = image.path{
                comicImageView.setImage(with: "\(path).\(image.type!)")
            }
        }
    }
}
