//
//  TemperatureInfoCell.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 04.06.2023.
//

import UIKit
import Kingfisher

class TemperatureInfoView: UIView {
    
    // MARK: - UI Elements
        
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 40
        return view
    }()
    
    lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - init
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        setupContainerView()
        setupDegreesLabel()
        setupConditionLabel()
        setupConditionImageView()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func setupDegreesLabel() {
        addSubview(degreesLabel)
        NSLayoutConstraint.activate([
            degreesLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            degreesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 48),
        ])
    }
    
    private func setupConditionLabel() {
        addSubview(conditionLabel)
        conditionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            conditionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            conditionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            conditionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: degreesLabel.trailingAnchor, constant: 4),
        ])
    }
    
    private func setupConditionImageView() {
        addSubview(conditionImageView)
        NSLayoutConstraint.activate([
            conditionImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            conditionImageView.leadingAnchor.constraint(greaterThanOrEqualTo: conditionLabel.trailingAnchor, constant: 4),
            conditionImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            conditionImageView.widthAnchor.constraint(equalToConstant: 40),
            conditionImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension TemperatureInfoView {
    
    struct TemperatureInfoData {
        let degrees: Int
        let description: String
        let imageUrl: String
    }
    
    func configure(with model: TemperatureInfoData) {
        degreesLabel.text = "\(model.degrees)°"
        conditionLabel.text = model.description
        
        if let url = URL(string: model.imageUrl) {
            conditionImageView.kf.setImage(with: url,
                                           options: [
                                            .transition(.fade(1)),
                                            .cacheOriginalImage,
                                           ])
        }
    }
}
