//
//  RouteNoServiceRow.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteNoServiceRow: View {
    let route: RouteViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                HStack(alignment: .top) {
                    routeName
                    HStack(alignment: .center) {
                        isFavoriteButton
                        routeAlternateName
                    }
                    Spacer()
                }
                HStack(alignment: .bottom) {
                    Spacer()
                    routeStatus
                }
            }
        }
        .padding(.all, 8)
    }
}

extension RouteNoServiceRow {
    var routeName: some View {
        RouteLogo(route: route)
    }
    
    var routeAlternateName: some View {
        Text(route.alternateName)
            .font(.caption)
    }
    
    var routeStatus: some View {
        Text(route.status)
            .font(.caption)
            .padding(.trailing, 18)
    }
    
    var isFavoriteButton: some View {
        FavoriteButton(route: route)
    }
}

struct RouteNoServiceRow_Previews: PreviewProvider {
    static var route = RouteViewModel(item: routesInfo.routes[0])
    static var previews: some View {
        RouteNoServiceRow(route: route)
    }
}
