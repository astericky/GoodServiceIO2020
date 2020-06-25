//
//  SlowZoneList.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct SlowZoneList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    var body: some View {
        NavigationView {
            List(routeInfoViewModel.slowZones, id: \.self) { line in
                NavigationLink(destination: LineDetail(line: line)) {
                    LineRow(line: line)
                }
            }
            .navigationBarTitle(Text("Slow Zones"))
        }
    }
}

struct SlowZoneList_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        SlowZoneList(routeInfoViewModel: routeInfoViewModel)
    }
}
