//
//  BrowseViewController.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 04/12/20.
//

import UIKit

class BrowseViewController: UIViewController {
    
    @IBOutlet weak var collectionViewTopPicks: UICollectionView!
    @IBOutlet weak var collectionViewRecentlyAdded: UICollectionView!
    @IBOutlet weak var collectionViewCharacters: UICollectionView!
    
    private var browseViewModel : BrowseViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Browse"
        self.navigationController?.navigationBar.topItem?.searchController = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browseViewModel = BrowseViewModel()
        
        collectionViewTopPicks.delegate = self
        collectionViewTopPicks.dataSource = self
        collectionViewRecentlyAdded.dataSource = self
        collectionViewRecentlyAdded.delegate = self
        initCharactersCollectionView()
        registerCells()
        
        
        browseViewModel.getComicCharacters(){ (loaded) in
            self.collectionViewCharacters.reloadData()
            self.reloadTopPicks()
        }
        
        browseViewModel.getLocalComicsList { (completion) in
            if completion {
                self.collectionViewRecentlyAdded.reloadData()
            }
        }

    }
    
    func reloadTopPicks(){
        self.browseViewModel.getComicsList { (completion) in
            if completion {
                self.collectionViewTopPicks.reloadData()
            }
        }
    }
    
    func initCharactersCollectionView(){
        collectionViewCharacters.delegate = self
        collectionViewCharacters.dataSource = self
    }
    
    func registerCells(){
        collectionViewCharacters.register(CharacterCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
    
    
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewTopPicks {
            if let comicDetail = UIStoryboard(name: "ComicDetail", bundle:nil).instantiateInitialViewController() as? ComicDetailViewController {
                
                comicDetail.comicDetailViewModel = ComicDetailViewModel(comic: browseViewModel.comics[indexPath.row])
                navigationController?.pushViewController(comicDetail, animated: true)
            }
        } else  if collectionView == collectionViewRecentlyAdded {
            if let comicDetail = UIStoryboard(name: "ComicDetail", bundle:nil).instantiateInitialViewController() as? ComicDetailViewController {
                
                comicDetail.comicDetailViewModel = ComicDetailViewModel(comic: browseViewModel.recentlyAddedComics[indexPath.row])
                navigationController?.pushViewController(comicDetail, animated: true)
            }
        } else {
            if let characterDetail = UIStoryboard(name: "CharacterDetail", bundle: nil).instantiateInitialViewController() as? CharacterDetail {
                characterDetail.characterDetailViewModel = CharacterDetailViewModel(character: browseViewModel.characters![indexPath.row])
                present(characterDetail, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewTopPicks {
            return browseViewModel.comics.count
        } else if collectionView == collectionViewRecentlyAdded {
            return browseViewModel.recentlyAddedComics.count
        } else {
            return browseViewModel.characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewTopPicks {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopPickCollectionViewCell", for: indexPath) as! TopPickCollectionViewCell
            
            cell.configure(with: browseViewModel.comics[indexPath.row])
            
            return cell
            
        } else if collectionView == collectionViewRecentlyAdded {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyCollectionViewCell", for: indexPath) as! RecentlyAddedCollectionViewCell
            
            cell.configure(with: browseViewModel.recentlyAddedComics[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
            
            let character:Character = (browseViewModel.characters?[indexPath.row])!
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    
}
