//
//  RouteLogo.swift
//  GoodServiceIO
//
//  Created by Chris Sanders on 10/10/20.
//

import SwiftUI

struct RouteLogo: View {
    var route: RouteViewModel
    var body: some View {
        Text(route.name)
            .font(.callout)
            .fontWeight(.semibold)
            .minimumScaleFactor(0.6)
            .foregroundColor(.white)
            .frame(width: 50.0, height: 50.0)
            .background(
                Circle()
                    .foregroundColor(route.color))
    }
}

struct RouteLogo_Previews: PreviewProvider {
    static var route = RouteViewModel(item: routesInfo.routes[0])
    static var previews: some View {
        RouteLogo(route: route)
    }
}
