//
//  LineDetail.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct LineDetail: View {
    var line: Line
    var body: some View {
        VStack(alignment: .leading) {
            header
            statusBar
//            lineNorthDirectionTable
//            lineSouthDirectionTable
            Spacer()
        }
        .navigationTitle(line.name)

    }
}

extension LineDetail {
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
//                Text(line.name)
//                    .font(.title)
//                    .fontWeight(.bold)
                HorizontalRouteList(routes: line.routes)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    var statusBar: some View {
        StatusBar(status: line.status, color: line.statusColor)
            .padding(.vertical, 20)
    }
    
//    var lineNorthDirectionTable: some View {
//        LineDirectionTable(name: "North", directionList: line.north)
//    }
//
//    var lineSouthDirectionTable: some View {
//        LineDirectionTable(name: "South", directionList: line.south)
//    }
}

struct LineDetail_Previews: PreviewProvider {
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
    static var previews: some View {
        LineDetail(line: lines[0])
    }
}
