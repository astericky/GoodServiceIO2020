//
//  RouteRow.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteRow: View {
    
    let route: Route
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: FavoriteItem.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FavoriteItem.title, ascending: true)
        ]
    ) var favorites: FetchedResults<FavoriteItem>
    
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
            .padding()
        }
    }
}

extension RouteRow {
    var routeName: some View {
        Text(route.name)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 50.0, height: 50.0)
            .background(route.color)
            .clipShape(Circle())
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
    static var route = Route(item: routesInfo.routes[0])
    static var route7x = Route(item: routesInfo.routes[8])
    static var previews: some View {
        Group {
            RouteRow(route: route)
                .previewLayout(.fixed(width: 375, height: 90))
            
            RouteRow(route: route7x)
                .previewLayout(.fixed(width: 375, height: 90))
        }
    }
}
