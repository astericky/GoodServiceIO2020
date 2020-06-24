//
//  LineList.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import SwiftUI

struct Borough: View {
    var borough: Borough
    
    var body: some View {
        List(lines) { line in
            NavigationLink(destination: LineDetail(viewModel: line)) {
                LineRow(viewModel: line)
            }
        }
        .navigationBarTitle(Text(viewModel.name))
    }
}

struct LineList_Previews: PreviewProvider {
    static var previews: some View {
        Borough()
    }
}
