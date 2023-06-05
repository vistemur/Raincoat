import UIKit
import CoreLocation

protocol MainScreenViewControllerInput {
    func setup(with model: MainScreenModel)
    func reloadTableView()
    func showDates(_ dates: [DaysScreenModel.Day])
    func enableMoreDatesButton()
}

class MainScreenViewController: UIViewController {
    
    var viewModel: MainScreenViewControllerOutput?
    
    // MARK: - UI properties
    
    lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var moreDatesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"),
                        for: .normal)
        button.addTarget(self, action: #selector(moreDatesButtonPressed), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var temperatureInfoView: TemperatureInfoView = {
        let view = TemperatureInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .none
        viewModel?.setup(tableView: tableView)
        return tableView
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        setup()
        viewModel?.viewDidLoad()
        super.viewDidLoad()
    }
    
    // MARK: - setup
    private func setup() {
        view.backgroundColor = .white
        setupPlaceLabel()
        setupDateLabel()
        setupMoreDatesButton()
        setupTemperatureInfoView()
        setupTableView()
    }
    
    private func setupPlaceLabel() {
        view.addSubview(placeLabel)
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            placeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            placeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupDateLabel() {
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupMoreDatesButton() {
        view.addSubview(moreDatesButton)
        NSLayoutConstraint.activate([
            moreDatesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            moreDatesButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            moreDatesButton.widthAnchor.constraint(equalToConstant: 48),
            moreDatesButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func setupTemperatureInfoView() {
        view.addSubview(temperatureInfoView)
        NSLayoutConstraint.activate([
            temperatureInfoView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32),
            temperatureInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            temperatureInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: temperatureInfoView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func moreDatesButtonPressed() {
        viewModel?.moreDatesButtonPressed()
    }
}

// MARK: - MainScreenViewControllerInput
extension MainScreenViewController: MainScreenViewControllerInput {
    
    func setup(with model: MainScreenModel) {
        DispatchQueue.main.async {
            self.placeLabel.text = model.place
            self.dateLabel.text = model.date
            
            self.temperatureInfoView.isHidden = true
            if let temperatureInfo = model.temperatureInfo {
                self.temperatureInfoView.configure(with: temperatureInfo)
                self.temperatureInfoView.isHidden = false
            }
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showDates(_ dates: [DaysScreenModel.Day]) {
        let viewController = DaysScreenViewController.assemble(days: dates)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func enableMoreDatesButton() {
        DispatchQueue.main.async {
            self.moreDatesButton.isHidden = false
        }
    }
}

// MARK: - Assemble
extension MainScreenViewController {
    
    static func assemble(userLocation: CLLocation?) -> UIViewController {
        let view = MainScreenViewController()
        let model = MainScreenModel()
        let viewModel = MainScreenViewModel(model: model,
                                            userLocation: userLocation)
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.model = model
        return view
    }
}
