//
//  RoutesView.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension RouteList {
    var routeList: some View {
        NavigationView {
            
        }
    }

    func content() -> some View {
        ForEach(routeInfoViewModel.routes, id: \.self) { route in
            self.selectView(for: route)
        }
    }
    
    func selectView(for route: RouteRowViewModel) -> some View {
        if (route.status == "No Service"
          || route.status == "Not Scheduled")  {
          return AnyView(RouteNoServiceRow(route: route))
        } else {
          return AnyView(
            RouteRow(route: route)
          )
        }
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        RouteList(routeInfoViewModel: routeInfoViewModel)
    }
}
