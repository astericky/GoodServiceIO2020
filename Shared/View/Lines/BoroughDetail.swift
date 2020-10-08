//
//  BoroughDetail.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct BoroughDetail: View {
    var borough: BoroughViewModel
    
    var body: some View {
        List(borough.lines.lines) { line in
            NavigationLink(destination: LineDetail(line: line)) {
                LineRow(line: line)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(borough.name))
        .navigationBarItems(trailing: VStack {
            Button(action: {}, label: {
                Image(systemName: "info.circle")
            })
        })
    }
}

struct BoroughDetail_Previews: PreviewProvider {
    static var routes = routesInfo.routes
    static var lines = LinesViewModel(lineItems: routesInfo.lines["Manhattan"]!)
    static var borough = BoroughViewModel(name: "Manhattan", lines: lines)
    static var previews: some View {
        BoroughDetail(borough: borough)
    }
}
