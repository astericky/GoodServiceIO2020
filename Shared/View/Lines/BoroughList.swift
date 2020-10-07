//
//  BoroughList.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct BoroughList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    @State private var showAboutModal = false
    
    var body: some View {
        NavigationView {
            List(content: content)
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(Text("Boroughs"))
                .navigationBarItems(
                    leading: VStack {
                        Text("status of new york city subway")
                            .font(.caption)
                            .textCase(.uppercase)
                    },
                    trailing: VStack {
                        Button(action: {
                            self.showAboutModal.toggle()
                        }, label: {
                            Image(systemName: "info.circle")
                        })
                    })
        }
            .sheet(isPresented: $showAboutModal) {
                AboutModal()
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
