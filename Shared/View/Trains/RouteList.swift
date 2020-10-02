//
//  RoutesList.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteList: View {
    @ObservedObject var routeInfoVM: RouteInfoViewModel
    
    @State private var showAboutModal = false
    
    var body: some View {
        ZStack {
            routeList
        }
            .sheet(isPresented: $showAboutModal) {
                AboutModal()
            }
    }
}

extension RouteList {
    private var routeList: some View {
        NavigationView {
            List(content: content)
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("Trains"))
                .navigationBarItems(leading: VStack{
                    Text("Status of New York City Subway")
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
    }
    
    private var subheader: some View {
        RouteListSubHeader(routeInfoViewModel: routeInfoVM)
    }
    
    private func content() -> some View {
        Group {
            subheader
            ForEach(routeInfoVM.routes, id: \.self) { (route) -> AnyView in
                return self.selectView(for: route)
            }
        }
    }
    
    private func selectView(for route: Route) -> AnyView {
        if route.status == "No Service"
            || route.status == "Not Scheduled" {
            return AnyView(RouteNoServiceRow(route: route))
        } else {
            return AnyView(
                RouteRow(route: route)
                    .padding(0)
            )
        }
    }
}

struct RouteList_Previews: PreviewProvider {
    static var routeInfoVM = RouteInfoViewModel()
    static var previews: some View {
        RouteList(routeInfoVM: routeInfoVM)
    }
}
