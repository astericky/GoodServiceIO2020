//
//  LineDirectionTable.swift
//  iOS
//
//  Created by Chris Sanders on 10/2/20.
//

import SwiftUI

struct LineDirectionTable: View {

    let names: [String]
    let directions: [LineDirectionViewModel]
    
    var body: some View {
        VStack {
            tableHeader
            lineDestinationList
        }
    }
}

extension LineDirectionTable {
    var tableHeader: some View {
        HStack {
            Spacer()
            Text(names.joined(separator: ", "))
                .font(.headline)
                .padding(.top, 16)
            Spacer()
        }
    }
    
    var lineDestinationList: some View {
        Group {
            ForEach(directions,
                    id: \.self,
                    content: LineDirectionRow.init(direction:))
        }
    }
}

//struct LineDirectionTable_Previews: PreviewProvider {
//    static var previews: some View {
//        LineDirectionTable()
//    }
//}
