import UIKit

protocol DaysScreenViewControllerInput {
    func reloadTableView()
}

class DaysScreenViewController: UIViewController {
    
    var viewModel: DaysScreenViewControllerOutput?
    
    // MARK: - UI properties
    
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
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - DaysScreenViewControllerInput
extension DaysScreenViewController: DaysScreenViewControllerInput {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Assemble
extension DaysScreenViewController {
    
    static func assemble(days: [DaysScreenModel.Day]) -> UIViewController {
        let view = DaysScreenViewController()
        let model = DaysScreenModel(days: days)
        let viewModel = DaysScreenViewModel(model: model)
        
        view.viewModel = viewModel
        viewModel.view = view
        return view
    }
}
