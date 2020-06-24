//
//  RoutesList.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    var body: some View {
        ZStack {
            routeList
        }
    }
}

extension RouteList {
    private var routeList: some View {
        NavigationView {
            List(content: content)
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("Trains"))
        }
    }
    
    private var subheader: some View {
        RouteListSubHeader(routeInfoViewModel: routeInfoViewModel)
    }
    
    private func content() -> some View {
        Group {
            subheader
            ForEach(routeInfoViewModel.routes, id: \.self) { route in
                self.selectView(for: route)
            }
        }
    }
    
    private func selectView(for route: Route) -> some View {
        if route.status == "No Service"
            || route.status == "Not Scheduled" {
            return AnyView(RouteNoServiceRow(route: route))
        } else {
            return AnyView(
                RouteRow(route: route)
                    .padding(0)
            )
        }
    }
}

struct RouteList_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        RouteList(routeInfoViewModel: routeInfoViewModel)
    }
}
