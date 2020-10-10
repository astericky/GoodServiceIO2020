//
//  RouteDestinationRow.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct RouteDestinationRow: View {
    var direction: RouteDirection
    let columns: [GridItem] = Array(repeating: .init(.fixed(80), spacing: 8), count: 4)
    var body: some View {
        VStack {
            HStack {
                LazyVGrid(columns: columns, alignment: .center) {
                    ColumnTitle("")
                    ColumnTitle("Scheduled Max Wait")
                    ColumnTitle("Actual Max Wait")
                    ColumnTitle("Traffic Conditions")
                    
                    ColumnTitle("\(direction.name)")
                    ColumnData("\(direction.maxScheduledWait) min")
                    ColumnData("\(direction.maxActualWait) min")
                    ColumnData("\(direction.trafficCondition.convertDecimalToPercentString())")
                }
            }
        }
            .background(Color(red: 0.9333, green: 0.9333, blue: 0.9333))
    }
}

struct ColumnTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding(.vertical, 4)
    }
    
    init(_ text: String) {
        self.text = text
    }
}

struct ColumnData: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .multilineTextAlignment(.center)
    }
    
    init(_ text: String) {
        self.text = text
    }
}

struct RouteDirectionRow_Previews: PreviewProvider {
    static var name = routesInfo.routes[20].destinations.south[0]
    static var directions = routesInfo.routes[20].south.map { RouteDirection(item: $0) }
    static var destination = RouteDestination(name: name, directions: directions)
    static var previews: some View {
        RouteDestinationRow(direction: destination.directions[0])
    }
}
