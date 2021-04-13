//
//  ComicDetailViewController.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 24/11/20.
//

import UIKit

class ComicDetailViewController: UIViewController {
    
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    
    var comicDetailViewModel:ComicDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initCharactersCollectionView()
        registerCells()
        initViewData()
        
        
        
    }
   
    func initViewData(){
        if let detailViewModel = comicDetailViewModel {
            self.titleLabel.text = detailViewModel.title
            self.summaryTextView.text = detailViewModel.description
            if let image = detailViewModel.image {
                comicImageView.setImage(with: image)
            }
            detailViewModel.getComicCharacters(){ (loaded) in
                self.charactersCollectionView.reloadData()
            }
        }
    }
    
    func initNavigationBar(){
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action:#selector(addTapped))
        
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.largeTitleDisplayMode = .never
        
        comicDetailViewModel.isComicOnLocalDatabase { (isOnLocal) in
            if isOnLocal{
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
            }
        }
    }
    
    func initCharactersCollectionView(){
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
    }
    
    func registerCells(){
        charactersCollectionView.register(CharacterCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
    
    @objc public func addTapped() {
        if comicDetailViewModel.isOnLocal{
            self.comicDetailViewModel.isOnLocal = false
            self.comicDetailViewModel.deleteComic()
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
        }else{
            self.comicDetailViewModel.isOnLocal = true
            self.comicDetailViewModel.saveComic()
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        // Text to share with other apps
        let textToShare = String(describing: comicDetailViewModel.title!)
        // URL, and or, and image to share with other apps
        guard let myAppURLToShare = URL(string:comicDetailViewModel.image!)else {
            return
        }
        let items = [textToShare, myAppURLToShare] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)

        //Apps to exclude sharing to
        /*avc.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
        ]*/
       
        //Present the shareView on iPhone
        self.present(avc, animated: true, completion: nil)
    }
    
   
    
}

extension ComicDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let characterDetail = UIStoryboard(name: "CharacterDetail", bundle: nil).instantiateInitialViewController() as? CharacterDetail {
            characterDetail.characterDetailViewModel = CharacterDetailViewModel(character: comicDetailViewModel.characters![indexPath.row])
            present(characterDetail, animated: true, completion: nil)
        }
    }
    
}
extension ComicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicDetailViewModel.characters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        
        let character:Character = (comicDetailViewModel.characters?[indexPath.row])!
        var url:String = ""
        if let image = character.thumbnail{
            if let path = image.path {
                url = "\(path).\(image.type!)"
            }
        }
        cell.setup(name: character.name, image: url)
        return cell
    }
    
}
