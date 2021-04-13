//
//  CharacterDetail.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 25/11/20.
//

import UIKit

class CharacterDetail: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var comiclinkButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var characterDetailViewModel:CharacterDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCharacterButtons()
        initDescriptionView()
        initCharacterData()
    }
    
    func initCharacterData(){
        nameLabel.text = characterDetailViewModel.name
        descriptionTextView.text = characterDetailViewModel.description
        initCharacterImageView()
        
    }
    
    func initCharacterImageView(){
        characterImageView.layer.cornerRadius = (characterImageView.frame.size.height)/2
        characterImageView.clipsToBounds = true
        if let image = characterDetailViewModel.image {
            characterImageView.setImage(with: image)
        }
    }
    
    func initCharacterButtons(){
        let cornerRadius:CGFloat = 10
        
        detailButton.layer.cornerRadius = cornerRadius
        detailButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        detailButton.isEnabled = !characterDetailViewModel.datailUrl!.isEmpty
        detailButton.tag = 0
        
        wikiButton.layer.cornerRadius = cornerRadius
        wikiButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        wikiButton.isEnabled = !characterDetailViewModel.wikiUrl!.isEmpty
        wikiButton.tag = 1
        
        comiclinkButton.layer.cornerRadius = cornerRadius
        comiclinkButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        comiclinkButton.isEnabled = !characterDetailViewModel.comiclink!.isEmpty
        comiclinkButton.tag = 2
        
    
        characterDetailViewModel.isFavorite { (isFavorite:Bool) in
            if isFavorite{
                self.favoriteButton.setImage( UIImage(systemName: "star.fill"), for: .normal)
            }else{
                self.favoriteButton.setImage( UIImage(systemName: "star"), for: .normal)
            }
        }
        
        favoriteButton.layer.cornerRadius = cornerRadius
        favoriteButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        favoriteButton.tag = 3
        
    }
    
    func initDescriptionView()  {
        descriptionView.layer.cornerRadius = 10
    }
    
    @objc public func buttonTapped(sender:UIButton!){
        var url:String?
        
        switch sender.tag {
        case 0:
            url = characterDetailViewModel.datailUrl
        case 1:
            url = characterDetailViewModel.wikiUrl
        case 2:
            url = characterDetailViewModel.comiclink
        case 3:
            if characterDetailViewModel.isFavorite{
                characterDetailViewModel.deleteCharacter()
                favoriteButton.setImage( UIImage(systemName: "star"), for: .normal)
                characterDetailViewModel.isFavorite = false
            }else{
                characterDetailViewModel.favoriteCharacter()
                favoriteButton.setImage( UIImage(systemName: "star.fill"), for: .normal)
                characterDetailViewModel.isFavorite = true
            }
            
        default:
            print("default")
        }
        
        if let path = url{
            UIApplication.shared.open(URL(string: path)!)
        }
    }
    
}



