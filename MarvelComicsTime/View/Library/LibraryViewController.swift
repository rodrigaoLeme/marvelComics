//
//  LibraryViewController.swift
//  MarvelComicsTime
//
//  Created by Yuri Cavalcanti on 24/11/20.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()
    private var libraryViewModel : LibraryViewModel!
    
    var searchController: UISearchController {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search"
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        return search
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Library"
        initSearchController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryViewModel = LibraryViewModel()
        
        initLibraryTableView()
        initSearchActivityIndicator()
        initLibraryViewControllerData()
        registerCells()
        
    
    }
    
    func registerCells(){
        libraryTableView.register(ComicTableViewCell.nib(), forCellReuseIdentifier: ComicTableViewCell.identifier)
    }
    
    
    func initLibraryTableView() {
        libraryTableView.delegate = self
        libraryTableView.dataSource = self
    }
    
    func  initSearchController() {
        self.navigationController?.navigationBar.topItem?.searchController = searchController
        self.navigationController?.navigationBar.topItem?.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    func initLibraryViewControllerData()  {
        activityIndicator.startAnimating()
        libraryViewModel.search(q: nil) { (loaded) in
            self.libraryTableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.libraryTableView.reloadData();
            self.libraryTableView.separatorStyle = .singleLine
        }
    }
    
    func initSearchActivityIndicator(){
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    
}

extension LibraryViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchBar)
        self.libraryTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        libraryViewModel.clearSearch()
        initLibraryViewControllerData()
    }
    
    func search (_ searchBar: UISearchBar){
        activityIndicator.startAnimating()
        if let search = searchBar.text {
            libraryViewModel.search(q: search){(loaded) in
                if loaded {
                    self.activityIndicator.stopAnimating()
                    self.libraryTableView.reloadData();
                    self.libraryTableView.separatorStyle = .singleLine
                }
            }
        }
    }
}


extension LibraryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let comicDetail = UIStoryboard(name: "ComicDetail", bundle: nil).instantiateInitialViewController() as? ComicDetailViewController {
            comicDetail.comicDetailViewModel = ComicDetailViewModel(comic:libraryViewModel.comics[indexPath.row])
            navigationController?.pushViewController(comicDetail, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryViewModel.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identifier, for: indexPath) as! ComicTableViewCell
        cell.setup(comic: libraryViewModel.comics[indexPath.row])
        return cell
        
    }
    
    
}
