//
//  RCRequest.swift
//  starRaces
//
//  Created by Roman Pozdnyakov on 16.05.2023.
//

import Foundation

protocol RCRequest {
    associatedtype Model: Decodable
    var query: String { get }
    var urlParameters: [String: String] { get }
    var httpMethod: HttpMethod { get }
}

enum HttpMethod: String {
    case GET
}

extension RCRequest {
    
    func request(_ completion: @escaping ((RequestResult<Model>) -> ())) {
        guard let url = getURL() else {
            completion(.error(error: UnknownError()))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.error(error: error))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let model = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(model: model))
                } catch {
                    completion(.error(error: error))
                }
            } else {
                completion(.error(error: UnknownError()))
            }
        }
        task.resume()
    }
    
    private func getURL() -> URL? {
        var urlComps = URLComponents(string: query)
        let queryItems = urlParameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
        urlComps?.queryItems = queryItems
        return urlComps?.url
    }
}
