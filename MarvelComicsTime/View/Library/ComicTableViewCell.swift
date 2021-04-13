//
//  ComicTableViewCell.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 24/11/20.
//

import UIKit

class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func setup(comic: Comic) {
        nameLabel.text = comic.title!
        summaryTextView.text = comic.description
        dateLabel.text = ""
        comicImageView?.image = UIImage(named: "")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
