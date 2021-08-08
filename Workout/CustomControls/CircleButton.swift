import SwiftUI

struct CircleButton: View {
    let action : () -> Void
    let label : String
    
    init(action: @escaping () -> Void, label: String) {
        self.action = action
        self.label = label
    }
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(self.label)
                .font(.system(size: 36))
                .fontWeight(.medium)
        })
        .buttonStyle(CircleOverlay())
    }
}

struct CircleOverlay: ButtonStyle {
    let pressedBackgroundColor = Color(UIColor(red: 0.93, green: 0.31, blue: 0.62, alpha: 1.00))
    let nonPressedBackgroundColor = Color(UIColor(red: 0.98, green: 0.85, blue: 0.92, alpha: 1.00))
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(configuration.isPressed ? pressedBackgroundColor : nonPressedBackgroundColor)
            .frame(width: 90, height: 90, alignment:.center)
            .overlay(
                Circle().stroke(Color.black, lineWidth: 1))
            .overlay(
                configuration.label
                    .foregroundColor(configuration.isPressed ? .white : .black)
            )
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(action: Nothing, label: "A")
    }
    
    static func Nothing(){
        for i in 1...5{
            print(i)
        }
    }
    
}
