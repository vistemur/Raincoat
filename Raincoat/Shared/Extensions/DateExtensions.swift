//
//  DateExtensions.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 05.06.2023.
//

import Foundation

extension Date {
    
    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
