//
//  LineDirectionRow.swift
//  iOS
//
//  Created by Chris Sanders on 10/2/20.
//

import SwiftUI

struct LineDirectionRow: View {
    var direction: LineDirectionViewModel
    let columns: [GridItem] = Array(repeating: .init(.fixed(80), spacing: 8), count: 4)
    
    var body: some View {
        VStack {
            HStack {
                LazyVGrid(columns: columns, alignment: .center) {
                    ColumnTitle("Service")
                    ColumnTitle("Scheduled Max Wait")
                    ColumnTitle("Actual Max Wait")
                    ColumnTitle("Traffic Conditions")
                    
                    ColumnTitle("\(direction.name)")
                    ColumnData("\(direction.maxScheduledWait) min")
                    ColumnData("\(direction.maxActualWait) min")
                    ColumnData("\(direction.trafficCondition.convertDecimalToPercentString())")
                }
            }
        }
            .background(Color(red: 0.9333, green: 0.9333, blue: 0.9333))
    }
}

//struct LineDirectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        LineDirectionRow()
//    }
//}
