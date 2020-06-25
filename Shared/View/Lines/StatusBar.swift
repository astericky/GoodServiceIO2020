//
//  StatusBar.swift
//  iOS
//
//  Created by Chris Sanders on 6/24/20.
//

import SwiftUI

struct StatusBar: View {
    var status = "Not Scheduled"
    var color = Color.black
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Text(status)
                    .font(.title)
                    .foregroundColor(color)
                    .fixedSize()
                Text("STATUS")
            }
            Spacer()
        }
        .padding()
        .background(Color(red: 100 / 255, green: 100 / 255, blue: 100 / 255))
        .foregroundColor(Color.white)
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar()
    }
}
