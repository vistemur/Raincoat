//
//  RequestResult.swift
//  starRaces
//
//  Created by Roman Pozdnyakov on 16.05.2023.
//

import Foundation

enum RequestResult<Model> {
    case success(model: Model)
    case error(error: Error)
}
