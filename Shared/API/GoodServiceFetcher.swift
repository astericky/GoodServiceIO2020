//
//  GoodServiceFetcher.swift
//  GoodService
//
//  Created by Chris Sanders on 9/24/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation
import Combine

protocol GoodServiceFetchable {
    func getInfo() -> AnyPublisher<InfoResponse, GoodServiceError>
    func getRouteMaps() -> AnyPublisher<RouteMapsResponse, GoodServiceError>
}

class GoodServiceFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension GoodServiceFetcher: GoodServiceFetchable {
    static let bundleInfoURL = Bundle.main.url(forResource: "info", withExtension: "json")
    static let infoURL = URL(string: "https://www.goodservice.io/api/info")
    
    func getInfo() -> AnyPublisher<InfoResponse, GoodServiceError> {
        #if DEBUG
            guard let url = GoodServiceFetcher.infoURL else {
                let error = GoodServiceError.network(description: "Couldn't create url.")
                return Fail(error: error).eraseToAnyPublisher()
            }
        #else
            guard let url = GoodServiceFetcher.infoURL else {
                let error = GoodServiceError.network(description: "Couldn't create url.")
                return Fail(error: error).eraseToAnyPublisher()
            }
        #endif
        
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = ISO8601DateFormatter().date(from: dateString) {
                return date
            }
            throw DateError.error(description: "There was an error decoding the date.")
        })
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .print()
            .decode(type: InfoResponse.self, decoder: decoder)
            .mapError { error in
                print(error)
                return .network(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    func getRouteMaps() -> AnyPublisher<RouteMapsResponse, GoodServiceError> {
        let urlString = "https://www.goodservice.io/api/routes"
        guard let url = URL(string: urlString) else {
            let error = GoodServiceError.network(description: "Couldn't create url.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .decode(type: RouteMapsResponse.self, decoder: JSONDecoder())
            .mapError { error in
                print(error)
                return .network(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
