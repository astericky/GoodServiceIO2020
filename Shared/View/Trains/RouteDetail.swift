//
//  RouteDetail.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteDetail: View {
    var route: Route

    @State private var showModal = false
    
    var body: some View {
        ScrollView {
            header
            status
        }
        .sheet(isPresented: $showModal) {
            Text("Hello Family")
        }
    }
}

extension RouteDetail {
    var header: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top) {
                Text(route.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .background(route.color)
                    .clipShape(Circle())

                Text(route.alternateName)
                    .font(.caption)
                Spacer()
            }
            .padding()
            routeMapButton
        }
    }
    
    var routeMapButton: some View {
        HStack(alignment: .bottom) {
          Spacer()
          Button("Route Map") {
            self.showModal.toggle()
          }
        }
        .padding(.trailing, 16)
    }
    
    var status: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Text(route.status)
                    .font(.title)
                    .foregroundColor(route.statusColor)
                    .fixedSize()
                Text("STATUS")
            }
            Spacer()
        }
        .padding()
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
    static var route = Route(item: routesInfo.routes[8])
    static var previews: some View {
        RouteDetail(route: route)
    }
}
