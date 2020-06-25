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
        List(borough.lines) { line in
            NavigationLink(destination: LineDetail(line: line)) {
                LineRow(line: line)
            }
        }
        .navigationBarTitle(Text(borough.name))
    }
}

struct BoroughDetail_Previews: PreviewProvider {
    static var routes = routesInfo.routes
    static var lines: [Line] = {
        routesInfo.lines["Manhattan"]!.map { item in
            var routestData = item.routes.flatMap { route in
                return routes.filter {
                    return $0.id == route.id
                }
            }
            let routesData = routestData.map { Route(item: $0) }
            return Line(item: item, routes: routesData)
        }
    }()
    static var borough = Borough(name: "Manhattan", lines: lines)
    static var previews: some View {
        BoroughDetail(borough: borough)
    }
}
