//
//  RouteDetail.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteDetail: View {
    var route: RouteViewModel

    @State private var showMapModal = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                header
                status
                routeDestintations
            }
        }
        .id(UUID().uuidString)
        .sheet(isPresented: $showMapModal) {
            MapModal(route: self.route)
        }
    }
}

extension RouteDetail {
    var header: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top) {
                routeName
                HStack {
                    isFavoriteButton
                    routeAlternateName
                }
                Spacer()
            }
//            routeMapButton
        }.padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
    }
    
    var routeName: some View {
        RouteLogo(route: route)
    }
    
    var routeAlternateName: some View {
        Text(route.alternateName)
            .font(.caption)
    }
    
    var isFavoriteButton: some View {
        FavoriteButton(route: route)
    }
    
    var routeMapButton: some View {
        HStack(alignment: .bottom) {
          Spacer()
          Button("Route Map") {
            self.showMapModal.toggle()
          }
        }
        .padding(.trailing, 16)
    }
    
    var status: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Text(route.status)
                    .font(.body)
                    .foregroundColor(route.statusColor)
                    .fixedSize()
                Text("STATUS")
                    .font(.callout)
            }
            Spacer()
        }
        .padding(.all, 8)
        .background(Color(red: 100 / 255, green: 100 / 255, blue: 100 / 255))
        .foregroundColor(Color.white)
    }
    
    var routeDestintations: some View {
        Group {
            RouteDestinationTable(destination: route.northDestination!)
            RouteDestinationTable(destination: route.southDestination!)
        }
    }
}

struct RouteDetail_Previews: PreviewProvider {
    static var route = RouteViewModel(item: routesInfo.routes[8])
    static var route2 = RouteViewModel(item: routesInfo.routes[9])
    static var previews: some View {
        Group {
            RouteDetail(route: route)
            RouteDetail(route: route2)
        }
    }
}
