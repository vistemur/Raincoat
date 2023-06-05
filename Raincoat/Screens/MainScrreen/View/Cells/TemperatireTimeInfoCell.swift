//
//  TemperatireTimeInfoCell.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 05.06.2023.
//

import UIKit

class TemperatireTimeInfoCell: UITableViewCell, RCCell {
    static let id = "TemperatireTimeInfoCell"
    
    // MARK: - UI Elements
        
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var temperatureInfoView: TemperatureInfoView = {
        let view = TemperatureInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        setupTimeLabel()
        setupTemperatureInfoView()
    }
    
    private func setupTimeLabel() {
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupTemperatureInfoView() {
        contentView.addSubview(temperatureInfoView)
        NSLayoutConstraint.activate([
            temperatureInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            temperatureInfoView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16),
            temperatureInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            temperatureInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

struct TemperatireTimeInfoCellData: RCCellData {
    typealias Cell = TemperatireTimeInfoCell
    
    let time: String
    let temperature: TemperatureInfoView.TemperatureInfoData
    
    func configure(cell: TemperatireTimeInfoCell) {
        cell.timeLabel.text = time
        cell.temperatureInfoView.configure(with: temperature)
    }
}


