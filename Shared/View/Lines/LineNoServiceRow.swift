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
                HorizontalRouteList(lineVM: line)
                Spacer()
                Text(line.status)
                    .font(.caption)
            }
            .padding(0)
        }
        .padding(10)
    }
}

struct LineNoServiceRow_Previews: PreviewProvider {
    static var lines = LinesViewModel(lineItems: routesInfo.lines["Manhattan"]!)
    static var previews: some View {
        LineNoServiceRow(line: lines.lines[0])
    }
}
