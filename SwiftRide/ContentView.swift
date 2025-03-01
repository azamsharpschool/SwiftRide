import SwiftUI

struct UberHomeScreen: View {
    @State private var selectedTab = "Rides"

    var body: some View {
        VStack(spacing: 0) {
            // Top Segmented Control (Rides & Eats)
            HStack(spacing: 40) {
                TopTabItem(icon: "car.fill", label: "Rides", isSelected: selectedTab == "Rides") {
                    selectedTab = "Rides"
                }
                TopTabItem(icon: "takeoutbag.and.cup.and.straw.fill", label: "Eats", isSelected: selectedTab == "Eats") {
                    selectedTab = "Eats"
                }
            }
            .padding(.top, 10)
            
            Divider()
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                Text("Where to?")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Button(action: {}) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Later")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
            .padding(.horizontal)
            
            // Recent Locations
            VStack(alignment: .leading, spacing: 8) {
                RecentTripView(destination: "High Meadow Ranch Golf Club", address: "37300 Golf Club Trail, Magnolia, TX 77355", icon: "clock")
                RecentTripView(destination: "George Bush Intercontinental Airport (IAH)", address: "2800 N Terminal Rd, Houston, TX", icon: "airplane.departure")
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            // Suggestions Section
            HStack {
                Text("Suggestions")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Text("See all")
                    .foregroundColor(.blue)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.horizontal)
            .padding(.top, 8)

            // Suggestions Icons
            HStack(spacing: 20) {
                SuggestionView(icon: "fork.knife", label: "Food")
                SuggestionView(icon: "car.fill", label: "Ride")
                SuggestionView(icon: "calendar", label: "Reserve", promo: true)
                SuggestionView(icon: "shippingbox.fill", label: "Courier")
            }
            .padding(.horizontal)

            // Promo Banner
            PromoBannerView()
                .padding(.horizontal)
                .padding(.top, 10)
            
            Spacer()
            
            // Bottom Tab Bar
            UberTabBar()
        }
    }
}

// MARK: - Top Tab Items
struct TopTabItem: View {
    let icon: String
    let label: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
            Text(label)
                .font(.system(size: 16, weight: isSelected ? .bold : .regular))
        }
        .foregroundColor(isSelected ? .black : .gray)
        .onTapGesture(perform: action)
    }
}



// MARK: - Suggestions
struct SuggestionView: View {
    let icon: String
    let label: String
    var promo: Bool = false

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.title)
                    .padding(16)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
                if promo {
                    Text("Promo")
                        .font(.caption2)
                        .padding(4)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .offset(x: 5, y: -5)
                }
            }
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
    }
}

// MARK: - Promo Banner
struct PromoBannerView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.green.opacity(0.15))
            .frame(height: 100)
            .overlay(
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Enjoy $35 off. Twice.")
                            .font(.system(size: 18, weight: .bold))
                        Button(action: {}) {
                            Text("Try Postmates")
                                .font(.system(size: 14, weight: .medium))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                                .shadow(radius: 2)
                        }
                    }
                    Spacer()
                    Image(systemName: "bag.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                }
                .padding()
            )
    }
}

// MARK: - Bottom Tab Bar
struct UberTabBar: View {
    var body: some View {
        HStack {
            TabBarItem(icon: "house.fill", label: "Home", selected: true)
            TabBarItem(icon: "square.grid.2x2.fill", label: "Services")
            TabBarItem(icon: "list.bullet", label: "Activity")
            TabBarItem(icon: "person.crop.circle", label: "Account")
        }
        .frame(height: 60)
        .background(Color.white)
        .shadow(radius: 5)
    }
}

// MARK: - Bottom Tab Items
struct TabBarItem: View {
    let icon: String
    let label: String
    var selected: Bool = false

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(selected ? .black : .gray)
            Text(label)
                .font(.system(size: 12, weight: selected ? .bold : .regular))
                .foregroundColor(selected ? .black : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
struct UberHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        UberHomeScreen()
    }
}
