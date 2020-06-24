//
//  RouteDirectionTable.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct RouteDestinationTable: View {
    var name: Route
    var routeDirectionList: [RouteDirection]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension RouteDestinationTable {
    var tableHeader: some View  {
        Text(name)
            .font(.headline)
            .padding(.top, 10)
    }
}


struct RouteDirectionTable_Previews: PreviewProvider {
    static var routeName = routesInfo.routes[20].destinations!.south[0]
    static var routeList = routesInfo.routes[20].south
    static var previews: some View {
        RouteDestinationTable()
    }
}
