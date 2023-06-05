//
//  SpacerCell.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 04.06.2023.
//

import UIKit

class SpacerCell: UITableViewCell, RCCell {
    static let id = "SpacerCell"
    
    // MARK: - UI Elements
        
    lazy var heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
    
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
        heightConstraint.isActive = true
    }
}

struct SpacerCellData: RCCellData {
    typealias Cell = SpacerCell
    
    let height: CGFloat

    func configure(cell: Cell) {
        cell.heightConstraint.constant = height
    }
}
