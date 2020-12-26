//
//  HorizontalRouteList.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct HorizontalRouteList: View {
    var lineRouteVMArray: [LineRouteViewModel]

    var body: some View {
        HStack {
            ForEach(lineRouteVMArray, id: \.self) { route in
                Text(route.name)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.white)
                    .padding(4)
                    .frame(width: 28, height: 28)
                    .background(Circle()
                                    .foregroundColor(route.color))
            }
        }
    }
}

struct HorizontalRouteList_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRouteList(lineRouteVMArray: lines[0].routes)
    }
}

