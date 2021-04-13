//
//  UserTableViewCell.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 28/01/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "UserTableViewCell", bundle: nil)
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(username:String?,email:String?,image:String?) {
        self.usernameLabel.text = username
        self.userEmailLabel.text = email
        if let image = image {
            userImageView.setImage(with: image)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
