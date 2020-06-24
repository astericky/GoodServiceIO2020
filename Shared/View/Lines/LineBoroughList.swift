//
//  LineBoroughList.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct BoroughList: View {
    @ObservedObject var viewModel: RouteInfoViewModel
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension BoroughList {
    func content() -> some View {
        ForEach(viewModel.lines, id: \.self) { borough in
            NavigationLink(destination: LineList(viewModel: borough)) {
            Text(borough.name)
            }
        }
    }
}

struct LineBoroughList_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        BoroughList(viewModel: routeInfoViewModel)
    }
}
