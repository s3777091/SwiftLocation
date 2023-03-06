import SwiftUI

struct LocationViewsList: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List(){
            ForEach(vm.locations){ lo in
                Button{
                    vm.showNextLocation(location: lo)
                }label: {
                    listRowViews(location: lo)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                
            }
        }.listStyle(PlainListStyle())
    }
}

struct LocationViewsList_Previews: PreviewProvider {
    static var previews: some View {
        LocationViewsList()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationViewsList{
    private func listRowViews(location: Location) -> some View{
        HStack{
            if let imageName = location.imageNames.first{
                AsyncImage(url: URL(string: imageName)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            }
            
            
            let title : String = location.name + " , " + location.cityName;
            
            if(title.count > 30) {
                AnimationTextCore(textValue: title, font: .systemFont(ofSize: 14, weight: .regular))
            }else{
                Text(title).font(.system(size: 14, weight: .regular))
            }
            
            
        }
    }
}
