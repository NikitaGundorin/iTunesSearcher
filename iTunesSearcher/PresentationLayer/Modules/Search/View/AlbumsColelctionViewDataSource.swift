//
//  AlbumsColelctionViewDataSource.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import UIKit

class AlbumsColelctionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Private properties
    
    private let cellId: String
    private var albumCellModels: [AlbumCellModel] = []
    private let loadAlbumImageBlock: (URL, @escaping (UIImage?) -> Void) -> Void
    
    // MARK: - Initializer
    
    init(cellId: String,
         loadAlbumImageBlock: @escaping (URL, @escaping (UIImage?) -> Void) -> Void) {
        self.cellId = cellId
        self.loadAlbumImageBlock = loadAlbumImageBlock
        super.init()
    }
    
    // MARK: - Public methods
    
    func setAlbumCellModels(models: [AlbumCellModel]) {
        albumCellModels = models
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
        if let imageUrl = model.imageUrl {
            loadAlbumImageBlock(imageUrl) { [weak self] image in
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
