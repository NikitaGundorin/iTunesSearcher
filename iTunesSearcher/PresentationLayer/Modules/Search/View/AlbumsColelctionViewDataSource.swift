//
//  AlbumsColelctionViewDataSource.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import UIKit

class AlbumsColelctionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Public properties
    
    var albums: [AlbumCellModel] {
        get {
            albumCellModels
        }
        set {
            albumCellModels = newValue
        }
    }
    
    // MARK: - Private properties
    
    private let cellId: String
    private var albumCellModels: [AlbumCellModel] = []
    private let loadAlbumImageBlock: (Int64, @escaping (UIImage?) -> Void) -> Void
    
    // MARK: - Initializer
    
    init(cellId: String,
         loadAlbumImageBlock: @escaping (Int64, @escaping (UIImage?) -> Void) -> Void) {
        self.cellId = cellId
        self.loadAlbumImageBlock = loadAlbumImageBlock
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albumCellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                            for: indexPath) as? AlbumCell
        else { return UICollectionViewCell() }
        let model = albumCellModels[indexPath.item]
        let id = model.albumId
        cell.configure(with: model)
        if model.imageUrl != nil {
            loadAlbumImageBlock(id) { [weak self] image in
                if let index = self?.albumCellModels.firstIndex(where: { $0.albumId == id }) {
                    self?.albumCellModels[index].image = image
                    collectionView.reloadData()
                }
            }
            albumCellModels[indexPath.item].imageUrl = nil
        }
        
        return cell
    }
}
