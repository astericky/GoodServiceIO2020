//
//  LineRow.swift
//  GoodService
//
//  Created by Chris Sanders on 9/17/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import SwiftUI

struct LineRow: View {

    var line: Line
    
    var body: some View {
        VStack {
            HStack {
                Text(line.name)
                Spacer()
            }
            Spacer()
            HStack(alignment: .bottom) {
                ForEach(line.routes) { route in
                    Text(route.name)
                        .foregroundColor(.white)
                        .frame(width: 25, height:25)
                        .background(route.color)
                        .clipShape(Circle())
                        .minimumScaleFactor(0.01)
                }
                Spacer()
                Text(line.status)
                    .font(.caption)
            }
            .padding(0)
        }
        .padding(10)
    }
}

struct LineRow_Previews: PreviewProvider {
    static var routes = routesInfo.routes
    static var lines: [Line] = {
        // loop through line array
        routesInfo.lines["Manhattan"]!.map { item in
            // TOTO: Refactor this to use HASH for search
            // loop through line route
            var routestData = item.routes.flatMap { route in
                // filter out non matching routes
                return routes.filter {
                    return $0.id == route.id
                }
            }
            // properly format routes
            let routesData = routestData.map { Route(item: $0) }
            return Line(item: item, routes: routesData)
        }
    }()
    static var previews: some View {
        Group {
            LineRow(line: lines[0])
                .previewLayout(.fixed(width: 320, height: 90))

            LineRow(line: lines[1])
                .previewLayout(.fixed(width: 320, height: 90))

            LineRow(line: lines[2])
                .previewLayout(.fixed(width: 320, height: 90))
        }
    }
}
