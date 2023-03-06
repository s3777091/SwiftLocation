//
//  LocationAnnotionViews.swift
//  NearFriends
//
//  Created by Nguyễn Sang on 14/07/2022.
//

import SwiftUI

struct LocationAnnotionViews: View {
    
    
    let accentColor = Color("AccentColor")
    

    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
            
        }
    }
}

struct LocationAnnotionViews_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            LocationAnnotionViews()
        }
    }
}
