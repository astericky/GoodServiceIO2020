//
//  RouteMapsViewModel.swift
//  iOS
//
//  Created by Chris Sanders on 7/8/20.
//

import SwiftUI
import Combine

class RouteMapsStore: ObservableObject {
    
    @Published var store: RouteMapsResponse?
    
    private var goodServiceFetcher = GoodServiceFetcher()
    private var goodServiceCancellable: AnyCancellable?
    
    init() {
        fetchRouteMaps()
    }
    
    func fetchRouteMaps() {
        goodServiceCancellable = goodServiceFetcher.getRouteMaps()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.reset()
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.store = value
                })
    }
    
    private func reset() {
        
    }
}
