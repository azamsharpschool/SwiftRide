import SwiftUI

struct ChooseARideScreen: View {
    
    @State private var selectedRide: RideOption?
    @Environment(SwiftRideStore.self) private var swiftRideStore 
    

    var body: some View {
        VStack {
            Text("Choose a ride")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            RideOptionListView(rideOptions: swiftRideStore.getRideOptions())
            
            /*
            List {
                
                ForEach(rideOptions) { ride in
                    RideOptionRow(ride: ride, isSelected: selectedRide?.id == ride.id)
                        .onTapGesture {
                            selectedRide = ride
                        }
                }
            }
            .listStyle(.plain)
             */
            
            // Payment Selection & Confirm Button
            /*
            VStack(spacing: 10) {
               
                Button(action: {
                    print("Selected Ride: \(selectedRide?.name ?? "None")")
                }) {
                    Text("Choose \(selectedRide?.name ?? "a ride")")
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
            */
            
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea())
    }
}

struct RideOptionRow: View {
    let ride: RideOption
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: ride.imageName)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())

            VStack(alignment: .leading) {
                HStack {
                   // Text(ride.name)
                     //   .fontWeight(.bold)
                    Image(systemName: "person.fill")
                   // Text("\(ride.passengers)")
                }
                Text("\(ride.arrivalTime) • \(ride.timeAway)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(ride.description)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            /*
            VStack(alignment: .trailing) {
                if let discount = ride.discountedPrice {
                    Text(discount)
                        .foregroundColor(.green)
                    Text(ride.price)
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.footnote)
                } else {
                    Text(ride.price)
                        .fontWeight(.bold)
                }
            } */
        }
        .padding()
        .background(isSelected ? Color.white.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
}

#Preview {
    ChooseARideScreen()
        .environment(SwiftRideStore(client: .development))
}
