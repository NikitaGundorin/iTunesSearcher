//
//  SearchViewController.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: ISearchPresenter?
    var searchQuery: String? {
        didSet {
            if let query = searchQuery {
                searchController.searchBar.text = searchQuery
                performSearch(searchText: query)
            }
        }
    }
    
    // MARK: - UI
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        let cellSize: CGFloat = view.bounds.width / 3 - padding * 1.5
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Appearance.backgroundColor
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = collectionViewDataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let padding: CGFloat = 10
    
    // MARK: - Private properties
    
    private let cellId = "albumCell"
    private lazy var collectionViewDataSource =
        AlbumsColelctionViewDataSource(cellId: cellId) { [weak self] albumId, completion in
            self?.presenter?.loadAlbumImage(albumId: albumId,
                                            completion: { [weak self] result in
                                                switch result {
                                                case .failure:
                                                    //ignore
                                                    return
                                                case .success(let image):
                                                    completion(image)
                                                }
                                            })
        }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupSearchBar()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = Appearance.backgroundColor
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func presentErrorAlert() {
        AlertHelper().presentErrorAlert(vc: self,
                                        message: "Error while loading albums. Please try again later.")
    }
    
    private func performSearch(searchText: String) {
        activityIndicatorView.startAnimating()
        presenter?.performSearch(forTerm: searchText) { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            switch result {
            case .failure:
                self?.presentErrorAlert()
            case .success(let albums):
                self?.collectionViewDataSource.albums = albums
            }
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showAlbumDetails(viewController: self,
                                    albumId: collectionViewDataSource.albums[indexPath.row].albumId)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.cancelLoading()
    }
}
