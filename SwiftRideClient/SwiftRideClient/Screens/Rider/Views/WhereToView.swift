import SwiftUI

struct WhereToView: View {
    
    @Binding var pickupAddress: String
    @Binding var destinationAddress: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Where to?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Enter your pickup and destination to request a ride.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 16) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pickup")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.green)
                            .font(.caption)
                        
                        TextField("Enter pickup address", text: $pickupAddress)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Destination")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.red)
                        
                        TextField("Enter destination address", text: $destinationAddress)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
   
}

#Preview {
    
    @Previewable @State var pickupAddress: String = "1200 McKinney St, Houston, TX"
    @Previewable @State var destinationAddress: String = "George Bush Intercontinental Airport, Houston, TX"
    
    NavigationStack {
        WhereToView(
            pickupAddress: $pickupAddress,
            destinationAddress: $destinationAddress
        )
    }
}
