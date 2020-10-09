//
//  MapModal.swift
//  iOS
//
//  Created by Chris Sanders on 6/25/20.
//

import SwiftUI
import MapKit

struct MapModal: View {
    var route: RouteViewModel
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
    var body: some View {
        Map(coordinateRegion: $region)
    }
    
    static var centerCoordinate = CLLocationCoordinate2D(latitude: 40.775712, longitude: -73.987954)
    static let span = MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.30)
}

#if DEBUG
struct MapModal_Previews: PreviewProvider {
    static var route = RouteViewModel(item: routesInfo.routes[8])
    static var previews: some View {
        MapModal(route: route)
    }
}
#endif
