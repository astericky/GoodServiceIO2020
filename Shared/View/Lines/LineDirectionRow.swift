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
                    
                    serviceData
                    ColumnData("\(direction.maxScheduledWait) min")
                    ColumnData("\(direction.maxActualWait) min")
                    ColumnData("\(direction.trafficCondition.convertDecimalToPercentString())")
                }
            }
        }
            .background(Color(red: 0.9333, green: 0.9333, blue: 0.9333))
    }
}

extension LineDirectionRow {
    // TODO: Refactor so this uses a default route
    var serviceData: some View {
        VStack {
            Text(direction.name.isEmpty ? "Local" : direction.name)
                .font(.system(size: 12))
                .fontWeight(.bold)
                .padding(.bottom, 2)
            
            HStack {
                ForEach(direction.routes, id: \.self) { route in
                    Text(route.name)
                        .foregroundColor(.white)
                        .frame(width: 25, height:25)
                        .background(Color.createColor(from: route.color))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.bottom, 8)
    }
}

//struct LineDirectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        LineDirectionRow()
//    }
//}
