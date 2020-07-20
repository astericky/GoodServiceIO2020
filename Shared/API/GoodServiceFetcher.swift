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
    func getInfo() -> AnyPublisher<InfoResponse, GoodServiceError> {
        let urlString = "https://www.goodservice.io/api/info"
        
        guard let url = URL(string: urlString) else {
            let error = GoodServiceError.network(description: "Couldn't create url.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .map { return $0.data }
            .decode(type: InfoResponse.self, decoder: JSONDecoder())
            .mapError { error in
                print(error)
                return .network(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    func getStationDetails() -> AnyPublisher<[String: Any], Error> {
//        print(try! Bundle.main.convertToJSON(from: "station-details.json"))
//        return Result(catching: {
//            try Bundle.main.decode(StationDetails.self, from: "station-details.json")
//        })
        return Result(catching: {
            try Bundle.main.convertToJSON(from: "station-details.json")
        })
        .publisher
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
