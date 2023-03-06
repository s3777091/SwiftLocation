import SwiftUI
import MapKit

struct LocationViews: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    var body: some View {
        ZStack{
            MapDesigner.ignoresSafeArea(.all)
            VStack(spacing: 0){
                tabHeader
                    .padding()
                Spacer()
                
                LocationReviews
                
            }
            
        }.sheet(item: $vm.showLocationDetail, onDismiss: nil) { lo in
            ReadDetail(location: lo)
        }
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct LocationViews_Previews: PreviewProvider {
    static var previews: some View {
        LocationViews()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationViews{
    
    private var tabHeader: some View {
        VStack{
            Button(action: vm.toggleLocationList){
                
                let title : String = vm.mapLocation.name + " , " + vm.mapLocation.cityName;
                
                if(title.count > 30) {
                    Button(action: vm.toggleLocationList){
                        
                        HStack{
                            
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees:  vm.showLocationsList ? 90 : 0))
                            
                            AnimationTextCore(textValue: title
                                              ,font: .systemFont(ofSize: 28, weight: .black))
                            .foregroundColor(.primary)
                            .animation(.none, value: vm.mapLocation)
                            
                        }.frame(width: UIScreen.screenWidth - 25, height: 65)
                    }
                }else{
                    Button(action: vm.toggleLocationList){
                        HStack{
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .rotationEffect(Angle(degrees:  vm.showLocationsList ? 90 : 0))
                            
                            Text(title)
                                .font(.title2).fontWeight(.black)
                                .foregroundColor(.primary)
                                .animation(.none, value: vm.mapLocation)
                        
                            
                        }.frame(width: UIScreen.screenWidth - 25, height: 65)

                    }
                    
                }
                
            }
            
            
            
            if vm.showLocationsList{
                LocationViewsList()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var MapDesigner: some View{
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { lo in
            MapAnnotation(coordinate: lo.coordinates){
                LocationAnnotionViews()
                    .scaleEffect(vm.mapLocation == lo  ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: lo)
                    }
            }
        })
    
    }
    
    
    private var LocationReviews: some View{
        ZStack{
            ForEach(vm.locations){ lo in
                if vm.mapLocation == lo{
                    LocationPreview(location: lo)
                        .shadow(color: Color.black.opacity(0.3), radius: 20).padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}

struct AnimationTextCore: View{
    var textValue: String
    
    var font: UIFont
    
    
    @State var storeSize : CGSize = .zero
    @State var offSet : CGFloat = 0
    
    var  animationSpeed : Double = 0.1
    var delay : Double = 0.5
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            Text(textValue)
                .font(Font(font))
                .offset(x: offSet)
            
        }.disabled(true)
            .onAppear{
                
                let base = textValue;
                
                (1...30).forEach{ _ in
                    textValue+" "
                }
                
                storeSize = TextSize()
                textValue+base
                
                let time: Double = (animationSpeed * storeSize.width)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: time)){
                        offSet = -storeSize.width
                    }
                }
            }.onReceive(Timer.publish(every: ((animationSpeed * storeSize.width)), on: .main, in: .default).autoconnect()){ _ in
                offSet = delay
                withAnimation(.linear(duration: (animationSpeed * storeSize.width))){
                    offSet = -storeSize.width
                }
                
            }
    }
    
    func TextSize() -> CGSize{
        let arrtri = [NSAttributedString.Key.font: font]
        let size = (textValue as NSString).size(withAttributes: arrtri)
        return size
    }
}

