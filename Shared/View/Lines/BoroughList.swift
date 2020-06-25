//
//  BoroughList.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct BoroughList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    var body: some View {
        NavigationView {
            List(content: content)
                .navigationTitle(Text("Boroughs"))
                .navigationBarItems(leading: VStack{
                    Text("status for new york city subway")
                        .font(.caption)
                },
                trailing: VStack {
                    Button(action: {}, label: {
                        Image(systemName: "info.circle")
                    })
                })
        }
    }
}

extension BoroughList {
    func content() -> some View {
        ForEach(routeInfoViewModel.boroughs, id: \.self) { borough in
            NavigationLink(destination: BoroughDetail(borough: borough)) {
                Text(borough.name)
            }
        }
    }
}

struct BoroughList_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        BoroughList(routeInfoViewModel: routeInfoViewModel)
    }
}
