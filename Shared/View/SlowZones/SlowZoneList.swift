//
//  SlowZoneList.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct SlowZoneList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    @State private var showAboutModal = false
    
    var body: some View {
        NavigationView {
            List(routeInfoViewModel.slowZones, id: \.self) { line in
                LineRow(line: line)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Slow Zones"), displayMode: .large)
            .navigationBarItems(
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

struct SlowZoneList_Previews: PreviewProvider {
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        SlowZoneList(routeInfoViewModel: routeInfoViewModel)
    }
}
