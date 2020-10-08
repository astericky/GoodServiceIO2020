//
//  HorizontalRouteList.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct HorizontalRouteList: View {
    var lineVM: LineViewModel

    var body: some View {
        HStack {
            ForEach(lineVM.routes, id: \.self) { route in
                Text(route.name)
                    .foregroundColor(.white)
                    .frame(width: 25, height:25)
                    .background(route.color)
                    .clipShape(Circle())
            }
        }
    }
}

struct HorizontalRouteList_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRouteList(lineVM: lines[0])
    }
}
