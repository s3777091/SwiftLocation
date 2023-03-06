//
//  ReadDetail.swift
//  NearFriends
//
//  Created by dat huynh on 18/07/2022.
//

import SwiftUI
import MapKit
struct ReadDetail: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                imageDetail.shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                
                    Divider()
                    
                    desciptionSection
                    
                    Divider()
                    
                    MapDetail
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }.ignoresSafeArea().background(.thinMaterial)
    }
}

struct ReadDetail_Previews: PreviewProvider {
    static var previews: some View {
        ReadDetail(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension ReadDetail{
    private var imageDetail: some View {
        TabView{
            ForEach(location.imageNames, id: \.self) { imageNames in
                AsyncImage(url: URL(string: imageNames)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
        }.frame(height: 500).tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    
    private var desciptionSection: some View{
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
            
            
            if let url = URL(string: location.link){
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
            

        }
    }
    
    
    private var MapDetail: some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: vm.mapSpan)),
            annotationItems: [location]){ lo in
            MapAnnotation(coordinate: location.coordinates) {
                LocationAnnotionViews().shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1,contentMode: .fit)
            .cornerRadius(30)
    }
}
