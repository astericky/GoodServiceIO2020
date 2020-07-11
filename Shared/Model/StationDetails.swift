//
//    StationDetails.swift
//    iOS
//
//    Created by Chris Sanders on 6/22/20.
//
//
//    Sample Data:
//    {
//        "101": {
//            "name": "Van Cortlandt Park - 242 St",
//            "longitude": -73.898583,
//            "latitude": 40.889248,
//            "borough": "Bx",
//            "north": {},
//            "south": {
//                "103": [
//                [
//                -73.899616,
//                40.887195
//                ],
//                [
//                -73.900041,
//                40.886309
//                ],
//                [
//                -73.90073,
//                40.884928
//                ]
//                ]
//            },
//            "bearing": 20.826502476411612
//        }
//    }

import Foundation
import MapKit

struct StationDetails: Codable {
    let station: [String: Station]
    
    struct Station: Codable {
        let id: String // GTFS Stop ID; This is the key in the station-details.json file.
        let name: String
        let borough: String
        let latitude: String
        let longitude: String
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
                latitude: CLLocationDegrees(self.latitude)!,
                longitude: CLLocationDegrees(self.longitude)!
            )
        }
        let north: [String: [[Double]]]
        let south: [String: [[Double]]]
        var coordinateListToNextStation: [String: [CLLocationCoordinate2D]] {
            var coordList: [String: [CLLocationCoordinate2D]] = [:]
            let keys = [String](south.keys)
             
            keys.forEach { key in
                // direction key is one of the next possible stations a train can travel to
                coordList[key] = south[key]?.map { coordItem in
                    CLLocationCoordinate2D(
                        latitude: coordItem[0],
                        longitude: coordItem[1]
                    )
                }
            }
            return coordList
        }
    }
    
    struct StationDirection: Codable {
        
    }
}


