//
//  RouteDestinationTable.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct RouteDestinationTable: View {
    
    var destination: RouteDestination
    
    var body: some View {
        VStack {
            tableHeader
            routeDestinationList
        }
    }
}

extension RouteDestinationTable {
    var tableHeader: some View {
        HStack {
            Spacer()
            Text(destination.name)
                .font(.headline)
                .padding(.top, 16)
            Spacer()
        }
    }
    
    var routeDestinationList: some View {
        Group {
            ForEach(destination.directions,
                    id: \.self,
                    content: RouteDestinationRow.init(direction:))
        }
    }
}

struct RouteDestinationTable_Previews: PreviewProvider {
    static var name = routesInfo.routes[20].destinations.south![0]
    static var directions = routesInfo.routes[20].south.map { RouteDirection(item: $0) }
    static var destination = RouteDestination(name: name, directions: directions)
    static var previews: some View {
        RouteDestinationTable(destination: destination)
            .previewLayout(.fixed(width: 375, height: 500))
    }
}
