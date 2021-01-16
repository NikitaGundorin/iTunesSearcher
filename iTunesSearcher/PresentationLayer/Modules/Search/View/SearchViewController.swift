//
//  SearchViewController.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - UI
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Private properties
    
    private var timer: Timer?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupSearchBar()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            
        }
    }
}
