import SwiftUI

struct ChooseARideScreen: View {
    
    @State private var selectedRide: RideOption?
    @Environment(SwiftRideStore.self) private var swiftRideStore 
    

    let rideOptions: [RideOption] = [
        RideOption(name: "Comfort", passengers: 4, price: "$32.06", discountedPrice: nil, arrivalTime: "11:57 PM", timeAway: "11 min away", description: "Newer cars with extra legroom", imageName: "car.fill", isSelected: true),
        RideOption(name: "UberX", passengers: 4, price: "$31.28", discountedPrice: "$25.93", arrivalTime: "11:56 PM", timeAway: "12 min away", description: "Affordable rides all to yourself", imageName: "car.fill", isSelected: false),
        RideOption(name: "UberXL", passengers: 6, price: "$40.37", discountedPrice: nil, arrivalTime: "11:47 PM", timeAway: "6 min away", description: "Affordable rides for groups up to 6", imageName: "bus.fill", isSelected: false),
        RideOption(name: "Black SUV", passengers: 6, price: "$77.86", discountedPrice: nil, arrivalTime: "11:51 PM", timeAway: "7 min away", description: "Luxury rides for 6 with professional drivers", imageName: "suv.fill", isSelected: false)
    ]

    var body: some View {
        VStack {
            Text("Choose a ride")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            List {
                ForEach(rideOptions) { ride in
                    RideOptionRow(ride: ride, isSelected: selectedRide?.id == ride.id)
                        .onTapGesture {
                            selectedRide = ride
                        }
                }
            }
            .listStyle(.plain)
            
            // Payment Selection & Confirm Button
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
                    Text(ride.name)
                        .fontWeight(.bold)
                    Image(systemName: "person.fill")
                    Text("\(ride.passengers)")
                }
                Text("\(ride.arrivalTime) • \(ride.timeAway)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(ride.description)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
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
            }
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
