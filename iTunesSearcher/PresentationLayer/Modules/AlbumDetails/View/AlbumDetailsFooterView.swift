//
//  AlbumDetailsFooterView.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

class AlbumDetailsFooterView: UIView {
    
    // MARK: - UI
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.regular12
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.regular12
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            releaseDateLabel,
            copyrightLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let padding: CGFloat = 10
    
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
            stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension AlbumDetailsFooterView: IConfigurableView {
    
    func configure(with model: AlbumModel) {
        if let releaseDate = model.releaseDate {
            releaseDateLabel.text = "Released: \(releaseDate.formatted())"
        }
        copyrightLabel.text = model.copyright
    }
}
