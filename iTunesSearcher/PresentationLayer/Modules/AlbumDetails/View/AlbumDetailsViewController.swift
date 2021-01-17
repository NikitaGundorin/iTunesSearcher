//
//  AlbumDetailsViewController.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: AlbumDetailsPresenter? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    private lazy var headerView = AlbumDetailsHeaderView()
    private lazy var footerView = AlbumDetailsFooterView()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.regular12
        label.numberOfLines = 0
        label.textColor = .systemPink
        label.textAlignment = .center
        return label
    }()
    
    private let padding: CGFloat = 20
    private let headerHeight: CGFloat = 300
    private let footerHeight: CGFloat = 80
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Private properties
    
    private let cellReuseIdentifier = "trackCell"
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        presenter?.loadAlbumDetails(completion: { [weak self] hasErrors in
            if hasErrors {
                self?.presentErrorAlert()
            }
            self?.updateUI()
        })
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = Appearance.backgroundColor
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateUI() {
        if let album = presenter?.album {
            headerView.configure(with: album)
            footerView.configure(with: album)
        }
        tableView.reloadData()
    }
    
    private func presentErrorAlert() {
        AlertHelper().presentErrorAlert(vc: self,
                                        message: "Loading album details failed. Please try again later.")
    }
}

// MARK: - UITableViewDataSource

extension AlbumDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        else { return UITableViewCell() }
        
        cell.textLabel?.text = presenter?.album.tracks[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.album.tracks.count ?? 0
    }
}

// MARK: - UITableViewDelegate

extension AlbumDetailsViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
}
