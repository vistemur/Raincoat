//
//  LabelCell.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 04.06.2023.
//

import UIKit

class LabelCell: UITableViewCell, RCCell {
    static let id = "LabelCell"
    
    // MARK: - UI Elements
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

struct LabelCellData: RCCellData {
    typealias Cell = LabelCell
    
    let title: String
    let textColor: UIColor
    let textAlignment: NSTextAlignment
    let font: UIFont
    let numberOfLines: Int
    
    func configure(cell: Cell) {
        cell.titleLabel.text = title
        cell.titleLabel.textColor = textColor
        cell.titleLabel.textAlignment = textAlignment
        cell.titleLabel.font = font
        cell.titleLabel.numberOfLines = numberOfLines
    }
    
    static func title(with text: String) -> LabelCellData {
        return LabelCellData(title: text,
                             textColor: .black,
                             textAlignment: .center,
                             font: .systemFont(ofSize: 26, weight: .bold),
                             numberOfLines: 0)
    }
}
