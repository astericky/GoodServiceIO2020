//
//  HorizontalRouteList.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct HorizontalRouteList: View {
    var routes: [RouteViewModel]
    var body: some View {
        HStack {
            ForEach(routes, id: \.self) { route in
                Text(route.name)
                    .foregroundColor(.white)
                    .frame(width: 25, height:25)
                    .background(route.color)
                    .clipShape(Circle())
            }
        }
    }
}

struct HorizontalRouteList_Previews: PreviewProvider {
    static var lineRoutes = [
        RouteViewModel(item: routesInfo.routes[0]),
        RouteViewModel(item: routesInfo.routes[5]),
        RouteViewModel(item: routesInfo.routes[8]),
        RouteViewModel(item: routesInfo.routes[11])
    ]
    static var previews: some View {
        HorizontalRouteList(routes: lineRoutes)
    }
}
