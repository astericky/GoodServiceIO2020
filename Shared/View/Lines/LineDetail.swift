//
//  LineDetail.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct LineDetail: View {
    
    var line: LineViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                header
                statusBar
                lineNorthDirectionTable
                lineSouthDirectionTable
                Spacer()
            }
        }
        .navigationTitle(line.name)
        
        
    }
}

extension LineDetail {
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
                HorizontalRouteList(lineRouteVMArray: line.routes)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    var statusBar: some View {
        StatusBar(status: line.status, color: line.statusColor)
            .padding(.vertical, 20)
    }
    
    var lineNorthDirectionTable: some View {
        var lineDirections: [LineDirectionViewModel] {
            line.north.map { LineDirectionViewModel(direction: $0) }
        }
        
        return LineDirectionTable(names: line.destinations.north,
                                  directions: lineDirections)
    }

    var lineSouthDirectionTable: some View {
        var lineDirections: [LineDirectionViewModel] {
            line.south.map { LineDirectionViewModel(direction: $0) }
        }
        return LineDirectionTable(names: line.destinations.south,
                                  directions: lineDirections)
    }
}

struct LineDetail_Previews: PreviewProvider {
    static var routes = routesInfo.routes
    static var lines: [LineViewModel] = {
        routesInfo.lines["Manhattan"]!.map { item in
            var routestData = item.routes.flatMap { route in
                return routes.filter {
                    return $0.id == route.id
                }
            }
            let routesData = routestData.map { RouteViewModel(item: $0) }
            return LineViewModel(item: item)
        }
    }()
    static var previews: some View {
        LineDetail(line: lines[0])
    }
}
