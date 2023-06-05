import Foundation

class DaysScreenModel {
    let days: [Day]
    
    init(days: [Day]) {
        self.days = days
    }
    
    class Day {
        let date: Date
        var minTemp: Int
        var maxTemp: Int
        
        init(date: Date, minTemp: Int, maxTemp: Int) {
            self.date = date
            self.minTemp = minTemp
            self.maxTemp = maxTemp
        }
    }
}
