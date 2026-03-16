import SwiftUI

struct ServiceOptionListView: View {
    
    let serviceTypes: [ServiceType]
    
    var body: some View {
        List(serviceTypes) { serviceType in
            HStack {
                
                VStack(alignment: .leading) {
                    Text(serviceType.name)
                        .font(.headline)
                    
                    Text("\(serviceType.maxPassengers) passengers")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text("$\(serviceType.baseFare, specifier: "%.2f")")
                    .font(.headline)
            }
            .padding(.vertical, 4)
        }
        .listStyle(.plain)
        .navigationTitle("Choose Ride")
    }
}

#Preview {
    NavigationStack {
        ServiceOptionListView(serviceTypes: ServiceType.preview)
    }
}
