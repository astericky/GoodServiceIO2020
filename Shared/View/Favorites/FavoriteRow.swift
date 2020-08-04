//
//  FavoriteRow.swift
//  iOS
//
//  Created by Chris Sanders on 8/2/20.
//

import SwiftUI

struct Favorite {
    var id: String
    var title: String
    var subtitle: String
    var color: Color
}


struct FavoriteRow: View {
    var favorite: Favorites
    let route: Route
    
    var body: some View {
        NavigationLink(destination: RouteDetail(route: route)) {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    HStack(alignment: .top) {
                        Text(route.name)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 50.0, height: 50.0)
                            .background(route.color)
                            .clipShape(Circle())
                        Text(route.alternateName)
                            .font(.caption)
                        Spacer()
                    }
                    
                    HStack(alignment: .bottom) {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(route.status)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

//struct FavoriteRow_Previews: PreviewProvider {
//    static var favorite = Favorites(context: <#T##NSManagedObjectContext#>)
//    static var previews: some View {
//        FavoriteRow()
//    }
//}
