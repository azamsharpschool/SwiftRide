import SwiftUI

struct ChooseARideScreen: View {
    
    @State private var selectedRide: RideEstimate?
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @State private var selectedServiceOption: ServiceOption?
    
    var body: some View {
        VStack {
            Text("Choose a ride")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            List(swiftRideStore.rideEstimates) { rideEstimate in
                RideEstimateView(rideEstimate: rideEstimate, onInfoSelected: {
                        selectedServiceOption = rideEstimate.serviceOption
                    })
                    .onTapGesture {
                        print("onTapGesture")
                        selectedRide = rideEstimate
                    }
                    .background(selectedRide == rideEstimate ? Color.blue.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
            }
            
            VStack(spacing: 10) {
               
                Button(action: {
                    print("Selected Ride:)")
                }) {
                    Text("Choose \(selectedRide?.title ?? "a ride")")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedRide != nil ? Color.blue.opacity(0.8) : Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                .disabled(selectedRide == nil)
            }
            .background(Color.black.opacity(0.05))
        }
        .sheet(item: $selectedServiceOption, content: { selectedServiceOption in
            NavigationStack {
                FarebreakdownScreen(serviceOption: selectedServiceOption)
            }
        })
        .task {
            try! await swiftRideStore.loadRideEstimates(coordinate:.apple)
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea())
    }
}

#Preview {
    ChooseARideScreen()
        .environment(SwiftRideStore(client: .development))
}
