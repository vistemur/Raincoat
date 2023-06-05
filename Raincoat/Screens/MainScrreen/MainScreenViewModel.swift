import UIKit
import CoreLocation

protocol MainScreenViewControllerOutput {
    func setup(tableView: UITableView)
    func viewDidLoad()
    func moreDatesButtonPressed()
}

class MainScreenViewModel: NSObject {
    
    var model: MainScreenModel
    weak var view: (MainScreenViewControllerInput & AnyObject)?
    
    private let date = Date()
    private let userLocation: CLLocation?
    private var rows = [any RCCellData]()
    private var dates: [DaysScreenModel.Day]?
    
    init(model: MainScreenModel,
         userLocation: CLLocation?) {
        self.model = model
        self.userLocation = userLocation
    }
}

// MARK: - MainScreenViewControllerOutput
extension MainScreenViewModel: MainScreenViewControllerOutput {
    
    func setup(tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(TemperatireTimeInfoCell.self, forCellReuseIdentifier: TemperatireTimeInfoCell.id)
        tableView.register(LabelCell.self, forCellReuseIdentifier: LabelCell.id)
        tableView.register(SpacerCell.self, forCellReuseIdentifier: SpacerCell.id)
    }
    
    func moreDatesButtonPressed() {
        if let dates = dates {
            view?.showDates(dates)
        }
    }
    
    func viewDidLoad() {        
        if let userLocation = userLocation {
            CurrentWeatherRequest(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude).request {
                [weak self] result in
                
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let model):
                    self.didObtainCurrentWeather(response: model)
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
            
            WeatherForecastRequest(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude).request {
                [weak self] result in
                
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let model):
                    self.didObtainWeatherForecast(response: model)
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func didObtainCurrentWeather(response: CurrentWeatherResponse) {
        model.place = response.name
        model.date = date.string(format: "dd.MM.yyyy")
        
        if let weather = response.weather.first {
            model.temperatureInfo = TemperatureInfoView.TemperatureInfoData(degrees: Int(response.main.temperature.rounded()),
                                                                            description: weather.description,
                                                                            imageUrl: "https://openweathermap.org/img/wn/\(weather.icon).png")
        }
        
        view?.setup(with: model)
    }
    
    private func didObtainWeatherForecast(response: WeatherForecastResponse) {
        var rows = [any RCCellData]()
        
        rows.append(LabelCellData(title: "Погода сегодня", textColor: .black, textAlignment: .left, font: .systemFont(ofSize: 24), numberOfLines: 0))
        rows.append(SpacerCellData(height: 16))
        for day in response.list {
            if let dayDate = day.date,
               dayDate.get(.day) == date.get(.day),
               let weather = day.weather.first {
                rows.append(TemperatireTimeInfoCellData(time: dayDate.string(format: "HH:mm"),
                                                        temperature: TemperatureInfoView.TemperatureInfoData(
                                                            degrees: Int(day.main.temperature.rounded()),
                                                            description:  weather.description,
                                                            imageUrl: "https://openweathermap.org/img/wn/\(weather.icon).png")))
                rows.append(SpacerCellData(height: 8))
            } else {
                break
            }
        }
        
        self.rows = rows
        view?.reloadTableView()
        prepareDates(from: response)
    }
    
    private func prepareDates(from response: WeatherForecastResponse) {
        var dates = [DaysScreenModel.Day]()
        
        var curDay: DaysScreenModel.Day?
        for day in response.list {
            if let dayDate = day.date {
                if let currentDay = curDay {
                    if dayDate.get(.day) == currentDay.date.get(.day) {
                        let minTemp = Int(day.main.temperatureMin.rounded())
                        let maxTemp = Int(day.main.temperatureMax.rounded())
                        
                        currentDay.minTemp = currentDay.minTemp < minTemp ? currentDay.minTemp : minTemp
                        currentDay.maxTemp = currentDay.maxTemp > maxTemp ? currentDay.maxTemp : maxTemp
                    } else {
                        dates.append(currentDay)
                        curDay = nil
                    }
                } else {
                    curDay = DaysScreenModel.Day(date: dayDate,
                                                 minTemp: Int(day.main.temperatureMin.rounded()),
                                                 maxTemp: Int(day.main.temperatureMax.rounded()))
                }
            }
        }
        
        self.dates = dates
        view?.enableMoreDatesButton()
    }
}

// MARK: - UITableViewDataSource
extension MainScreenViewModel: UITableViewDataSource {
        
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
