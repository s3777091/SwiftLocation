import SwiftUI

struct LocationPreview: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    var body: some View {
        Button{
            vm.showLocationDetail = location
        } label: {
            HStack(alignment: .center){
                imageSection
                
                titleSection
            }
        }.frame(width: UIScreen.screenWidth - 40, height: 95, alignment: .bottom)
            .background(RoundedRectangle(cornerRadius: 15).fill(.thinMaterial))
    }
    
    struct LocationPreview_Previews: PreviewProvider {
        static var previews: some View {
            ZStack{
                LocationPreview(location: LocationsDataService.locations.first!)
            }.environmentObject(LocationsViewModel())
        }
    }
    
}

extension LocationPreview{
    public var imageSection: some View {
        ZStack{
            if let imageName = location.imageNames.first{
                AsyncImage(url: URL(string: imageName)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                .frame(width: 75, height: 75)
                .cornerRadius(10)
            }
        }
        .cornerRadius(10).padding(10)
    }
    
    
    private var titleSection: some View {
        VStack(alignment: .leading){
            
            if(location.name.count > 20) {
                AnimationTextCore(textValue: location.name, font: .systemFont(ofSize: 24, weight: .bold))
            }else{
                Text(location.name).font(.system(size: 24, weight: .bold))
            }
            
            Text(location.cityName)
                .font(.subheadline)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
