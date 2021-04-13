//
//  SearchViewController.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 04/12/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchViewModel:SearchViewModel!
    
    var safeArea: UILayoutGuide!
    let searchHistoryTableViewController = SearchHistoryTableViewController()
    var activityIndicator = UIActivityIndicatorView()
    var searchController: UISearchController {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "All Comics"
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.scopeButtonTitles = ["All Comics", "Your Library"]
        search.searchBar.delegate = self
        return search
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Search"
        initSearchController()
        initSearchTableView()
        initSearchActivityIndicator()
        //setupSearchHistoryTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel()
        safeArea = view.layoutMarginsGuide
       
        initSearchTableView()
        initSearchActivityIndicator()
        setupSearchHistoryTableView()
        registerCells()
    }
    
    func initSearchTableView(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func registerCells(){
        searchTableView.register(ComicTableViewCell.nib(), forCellReuseIdentifier: ComicTableViewCell.identifier)
    }
    
    func initSearchController() {
        self.navigationController?.navigationBar.topItem?.searchController = searchController
        self.navigationController?.navigationBar.topItem?.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    func initSearchActivityIndicator(){
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func setupSearchHistoryTableView() {
        self.view.addSubview(searchHistoryTableViewController.tableView)
        searchHistoryTableViewController.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchHistoryTableViewController.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchHistoryTableViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchHistoryTableViewController.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        
    }
    
}

extension SearchViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHistoryTableViewController.didSelectItem = { (text) in
            searchBar.text = text
            self.search(searchBar)
            self.searchHistoryTableViewController.tableView.removeFromSuperview()
        }
        let isLibrary = searchBar.selectedScopeButtonIndex == LibraryScope.local.rawValue
        if !searchText.isEmpty && !isLibrary{
            searchHistoryTableViewController.setSearchText(text: searchText)
            setupSearchHistoryTableView()
        }else{
            searchHistoryTableViewController.tableView.removeFromSuperview()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let isLibrary = selectedScope == LibraryScope.local.rawValue
        searchBar.placeholder = isLibrary ? "Your Library": "All Comics"
        
        if isLibrary{
            searchHistoryTableViewController.tableView.removeFromSuperview()
        }
        
        searchViewModel.clearSearch()
        self.searchTableView.reloadData()
        search(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchHistoryTableViewController.tableView.removeFromSuperview()
        if let search = searchBar.text {
            searchViewModel.saveSearch(search:search)
        }
        search(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchHistoryTableViewController.tableView.removeFromSuperview()
        searchViewModel.clearSearch()
        self.searchTableView.reloadData()
        self.searchTableView.separatorStyle = .none
    }
    
    func search (_ searchBar: UISearchBar){
        activityIndicator.startAnimating()
        if let search = searchBar.text {
            let scope = LibraryScope.init(rawValue: searchBar.selectedScopeButtonIndex)
            searchViewModel.search(q: search, scope:scope!){(loaded) in
                if loaded {
                    self.activityIndicator.stopAnimating()
                    self.searchTableView.reloadData();
                    self.searchTableView.separatorStyle = .singleLine
                }
            }
        }
    }
    
    @objc public func userTapped() {
        FirebaseMarvelComicService.logout()
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let comicDetail = UIStoryboard(name: "ComicDetail", bundle:nil).instantiateInitialViewController() as? ComicDetailViewController {
            
            comicDetail.comicDetailViewModel = ComicDetailViewModel(comic:searchViewModel.comics[indexPath.row])
            
            navigationController?.pushViewController(comicDetail, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identifier, for: indexPath) as! ComicTableViewCell
        cell.setup(comic: searchViewModel.comics[indexPath.row])
        return cell
        
    }
    
    
}
