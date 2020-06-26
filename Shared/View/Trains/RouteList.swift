//
//  RoutesList.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct RouteList: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    @State private var showAboutModal = false
    
    var body: some View {
        ZStack {
            routeList
        }
            .sheet(isPresented: $showAboutModal) {
                VStack {
                    Text("What is Good Service?")
                        .font(.headline)
                        .padding(.bottom)
                    Text("goodservice.io's goal is to provide an up-to-date and detailed view of the New York City subway system using the publicly available GTFS and GTFS-RT data. It is an open source project, and the source code can be found on GitHub. Currently, it displays maximum wait times (i.e. train headways or frequency), train delays and traffic conditions.")
                        .font(.caption)
                    Spacer()
                }
                    .padding()
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
                    Text("status of new york city subway")
                        .font(.caption)
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
        RouteListSubHeader(routeInfoViewModel: routeInfoViewModel)
    }
    
    private func content() -> some View {
        Group {
            subheader
            ForEach(routeInfoViewModel.routes, id: \.self) { route in
                self.selectView(for: route)
            }
        }
    }
    
    private func selectView(for route: Route) -> some View {
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
    static var routeInfoViewModel = RouteInfoViewModel()
    static var previews: some View {
        RouteList(routeInfoViewModel: routeInfoViewModel)
    }
}
