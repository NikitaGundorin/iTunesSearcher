//
//  AlbumCell.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: placeholderImage)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let placeholderImage = UIImage(named: "AlbumImagePlaceholder")
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setPlaceholderImage()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setPlaceholderImage() {
        imageView.image = placeholderImage
    }
}

// MARK: - IConfigurableView

extension AlbumCell: IConfigurableView {
    
    func configure(with model: AlbumCellModel) {
        if let image = model.image {
            imageView.image = image
        } else {
            setPlaceholderImage()
        }
    }
}
