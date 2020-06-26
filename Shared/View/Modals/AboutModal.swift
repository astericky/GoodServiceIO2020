//
//  AboutModal.swift
//  iOS
//
//  Created by Chris Sanders on 6/25/20.
//

import SwiftUI

struct AboutModal: View {
    var body: some View {
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

struct AboutModal_Previews: PreviewProvider {
    static var previews: some View {
        AboutModal()
    }
}
