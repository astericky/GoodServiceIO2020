//
//  RouteListSubHeader.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct RouteListSubHeader: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    var body: some View {
        HStack {
            Text("Updated: \(routeInfoViewModel.datetime)")
                .font(.caption)
            Spacer()
            Button(action: {
                self.routeInfoViewModel.fetchRouteInfo()
            }, label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                }
            })
        }
    }
}

struct RouteListSubHeader_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        RouteListSubHeader(routeInfoViewModel: routeInfoViewModel)
    }
}
