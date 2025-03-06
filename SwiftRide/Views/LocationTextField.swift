
import SwiftUI

struct LocationTextField: View {
    var placeholder: String
    @Binding var text: String
    var iconName: String
    var iconColor: Color
    var onTap: () -> Void
    var onChange: (String) -> Void
    
  
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: iconName)
                        .foregroundColor(iconColor)
                    TextField(placeholder, text: $text)
                        .textFieldStyle(PlainTextFieldStyle())
                        .onChange(of: text) {
                            onChange(text)
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            onTap()
                        }))
                }
                .padding(.horizontal)
                .contentShape(Rectangle()) // Ensure the entire HStack is tappable
            )
    }
}
