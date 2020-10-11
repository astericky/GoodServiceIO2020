//
//  LineRow.swift
//  GoodService
//
//  Created by Chris Sanders on 9/17/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import SwiftUI

struct LineRow: View {

    var line: LineViewModel
    
    var body: some View {
        NavigationLink(destination: LineDetail(line: line)) {
            VStack {
                HStack {
                    Text(line.name)
                    Spacer()
                }
                Spacer()
                HStack(alignment: .bottom) {
                    ForEach(line.routes, id: \.self) { route in
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
            .padding(8)
        }
    }
}

struct LineRow_Previews: PreviewProvider {
    static var routes = routesInfo.routes
    static var lines: [LineViewModel] = {
        routesInfo.lines["Manhattan"]!.map { item in
            LineViewModel(item: item)
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
