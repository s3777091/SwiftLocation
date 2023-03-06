
import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject{
    
    // MARK: - Load data
    @Published var locations : [Location]
    
    // MARK: - Current Location on map
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    // MARK: - Current Region on map
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    
    
    // MARK: - Show List of Locations

    @Published var showLocationsList: Bool = false
    
    // MARK - Show Locations Detail
    
    @Published var showLocationDetail: Location? = nil

    
    init(){
        let locations = LocationsDataService.locations
        
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.linear(duration: 0.2)) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, span: mapSpan
            )
        }
        
    }
    
    func toggleLocationList(){
        withAnimation(.linear){
            showLocationsList = !showLocationsList
        }
    }
    
    
    func showNextLocation(location: Location){
        withAnimation(.linear(duration: 0.2)){
            mapLocation = location
            showLocationsList = false
        }
    }
    
}


