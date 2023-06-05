import UIKit

protocol DaysScreenViewControllerOutput {
    func setup(tableView: UITableView)
    func viewDidLoad()
}

class DaysScreenViewModel: NSObject {
    
    private var model: DaysScreenModel
    weak var view: (DaysScreenViewControllerInput & AnyObject)?
    
    private var rows = [any RCCellData]()
    
    init(model: DaysScreenModel) {
        self.model = model
    }
}

// MARK: - DaysScreenViewControllerOutput
extension DaysScreenViewModel: DaysScreenViewControllerOutput {
    
    func setup(tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(TemperatireTimeInfoCell.self, forCellReuseIdentifier: TemperatireTimeInfoCell.id)
        tableView.register(LabelCell.self, forCellReuseIdentifier: LabelCell.id)
        tableView.register(SpacerCell.self, forCellReuseIdentifier: SpacerCell.id)
    }
    
    func viewDidLoad() {
        rows = model.days.map({ LabelCellData(title: "\($0.date.string(format: "dd.MM.yyyy")) min: \($0.minTemp) max: \($0.maxTemp)",
                                              textColor: .black,
                                              textAlignment: .left,
                                              font: .systemFont(ofSize: 16),
                                              numberOfLines: 1) })
        view?.reloadTableView()
    }
}

// MARK: - UITableViewDataSource
extension DaysScreenViewModel: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellId , for: indexPath)
        row.configure(cell: cell)
        return cell
    }
}
