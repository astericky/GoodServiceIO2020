//
//  BoroughDetail.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct BoroughDetail: View {
    var borough: Borough
    
    var body: some View {
        NavigationView {
            List(borough.lines) { line in
                Text(line.name)
    //            NavigationLink(destination: LineDetail(viewModel: line)) {
    //                LineRow(viewModel: line)
    //            }
            }
            .navigationBarTitle(Text(borough.name))
        }
    }
}

struct BoroughDetail_Previews: PreviewProvider {
    static var routes = routesInfo.routes
    static var lines: [Line] = {
        routesInfo.lines["Manhattan"]!.map { item in
            let routesTestData = routes.filter { $0.id == item.id }
            let routesData = routesTestData.map { Route(item: $0) }
            return Line(item: item, routes: routesData)
        }
    }()
    static var borough = Borough(name: "Manhattan", lines: lines)
    static var previews: some View {
        BoroughDetail(borough: borough)
    }
}
