//
//  LineNoServiceRow.swift
//  iOS
//
//  Created by Chris Sanders on 10/7/20.
//

import SwiftUI

struct LineNoServiceRow: View {
    var line: LineViewModel

    var body: some View {
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
        .padding(10)
    }
}

#if DEBUG
struct LineNoServiceRow_Previews: PreviewProvider {
    static var lines = LinesViewModel(lineItems: routesInfo.lines["Manhattan"]!)
    static var previews: some View {
        LineNoServiceRow(line: lines.lines[0])
    }
}
#endif
