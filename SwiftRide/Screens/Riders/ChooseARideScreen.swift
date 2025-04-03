import SwiftUI

struct ChooseARideScreen: View {
    
    @State private var selectedRide: RideEstimate?
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @State private var selectedServiceOption: ServiceOption?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Choose a Ride")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 24)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(swiftRideStore.rideEstimates) { rideEstimate in
                            RideEstimateView(rideEstimate: rideEstimate, onInfoSelected: {
                                selectedServiceOption = rideEstimate.serviceOption
                            })
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(selectedRide == rideEstimate ? Color.blue.opacity(0.15) : Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            )
                            .onTapGesture {
                                selectedRide = rideEstimate
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 16)
                }

                Button(action: {
                    print("Selected Ride: \(selectedRide?.title ?? "")")
                }) {
                    Text(selectedRide != nil ? "Choose \(selectedRide?.title ?? "")" : "Choose a ride")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedRide != nil ? Color.blue : Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(12)
                }
                .disabled(selectedRide == nil)
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .sheet(item: $selectedServiceOption) { option in
                NavigationStack {
                    FarebreakdownScreen(serviceOption: option)
                }
            }
            .task {
                try? await swiftRideStore.loadRideEstimates(from: .apple, to: .apple)
            }
        }
    }
}

#Preview {
    ChooseARideScreen()
        .environment(SwiftRideStore(client: .development))
}
