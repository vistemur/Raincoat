//
//  CellProtocols.swift
//  textMVVM
//
//  Created by Roman Pozdnyakov on 22.04.2023.
//

import UIKit

protocol RCCell: UITableViewCell {
    static var id: String { get }
}

protocol RCCellData {
    associatedtype Cell: RCCell
    func configure(cell: Cell)
}

extension RCCellData {
    func configure(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            configure(cell: cell)
        }
    }
}

extension RCCellData {
    var cellId: String { Cell.id }
}
