//
//  AlbumDetailsHeaderView.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

class AlbumDetailsHeaderView: UIView {
    
    // MARK: - UI
    
    private lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AlbumImagePlaceholderLarge"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.semibold16
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.regular14
        label.numberOfLines = 0
        label.textColor = .systemPink
        label.textAlignment = .center
        return label
    }()
    
    private lazy var genreNameLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.regular12
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            artworkImageView,
            albumNameLabel,
            artistNameLabel,
            genreNameLabel
        ])
        stackView.axis = .vertical
        stackView.setCustomSpacing(imageSpacing, after: artworkImageView)
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let padding: CGFloat = 20
    private let imageSpacing: CGFloat = 10
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding)
        ])
    }
}

// MARK: - ConfigurableView

extension AlbumDetailsHeaderView: IConfigurableView {
    
    func configure(with model: AlbumModel) {
        albumNameLabel.text = model.albumName
        artistNameLabel.text = model.artistName
        genreNameLabel.text = model.genreName
        if let image = model.image {
            artworkImageView.image = image
        }
    }
}
