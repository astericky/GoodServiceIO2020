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
        tableHeader
    }
}

extension RouteDestinationTable {
    var tableHeader: some View  {
        Text(destination.name)
            .font(.headline)
            .padding(.top, 10)
    }
}


struct RouteDestinationTable_Previews: PreviewProvider {
    static var name = routesInfo.routes[20].destinations.south[0]
    static var directions = routesInfo.routes[20].south.map { RouteDirection(item: $0) }
    static var destination = RouteDestination(name: name, directions: directions)
    static var previews: some View {
        RouteDestinationTable(destination: destination)
    }
}
