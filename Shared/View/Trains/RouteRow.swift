//
//  RouteRow.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteRow: View {
    
    let route: RouteViewModel
        
    var body: some View {
        NavigationLink(destination: RouteDetail(route: route)) {
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
                        VStack(alignment: .trailing) {
                            routeStatus
                        }
                    }
                }
            }
            .padding(.all, 8)
        }
    }
}

extension RouteRow {
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
    }
    
    var isFavoriteButton: some View {
        FavoriteButton(route: route)
    }

}

struct RouteRow_Previews: PreviewProvider {
    static var route = RouteViewModel(item: routesInfo.routes[0])
    static var route7x = RouteViewModel(item: routesInfo.routes[8])
    static var previews: some View {
        Group {
            RouteRow(route: route)
                .previewLayout(.fixed(width: 375, height: 90))
            
            RouteRow(route: route7x)
                .previewLayout(.fixed(width: 375, height: 90))
        }
    }
}
