import SwiftUI

struct HourHand: View {
    var diameter: CGFloat
    var hour: Int
    var minute: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "#646E82"))
                .frame(width: 0.012 * diameter, height: 0.14 * diameter)
            Polygon(corners: 3, size: CGSize(width: 0.0375 * diameter, height: 0.02 * diameter))
                .fill(Color(hex: "#646E82"))
                .rotationEffect(.degrees(-90))
                .offset(y: -0.05 * diameter)
        }
        .offset(y: -0.09 * diameter)
        .rotationEffect(.degrees(Double(hour % 12) * 30 + Double(minute) * 0.5))
    }
}

struct MinuteHand: View {
    var diameter: CGFloat
    var minute: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0.005 * diameter)
            .fill(Color(hex: "#646E82"))
            .frame(width: 0.005 * diameter, height: 0.27 * diameter)
            .offset(y: -0.135 * diameter)
            .rotationEffect(.degrees(Double(minute) * 6))
    }
}

struct SecondHand: View {
    var diameter: CGFloat
    var second: Int
    
    var body: some View {
        ZStack {
            // Part of the hand that extends behind the center pin
            RoundedRectangle(cornerRadius: 0.0025 * diameter)
                .fill(Color.red)
                .frame(width: 0.008 * diameter, height: 0.1 * diameter)
                .offset(y: 0.1 * diameter)
            RoundedRectangle(cornerRadius: 0.0025 * diameter)
                .fill(Color.red)
                .frame(width: 0.0025 * diameter, height: 0.05 * diameter)
                .offset(y: 0.025 * diameter)

            RoundedRectangle(cornerRadius: 0.0025 * diameter)
                .fill(Color.red)
                .frame(width: 0.0025 * diameter, height: 0.32 * diameter)
                .offset(y: -0.16 * diameter)
        }
        .rotationEffect(.degrees(Double(second) * 6))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}

struct CenterPin: View {
    var diameter: CGFloat
    
    var body: some View {
        // Outer Circle of Center Pin
        Circle()
            .fill(Color(hex: "#646E82"))
            .frame(width: 0.05 * diameter, height: 0.05 * diameter)

        // Inner Circle (Center Pin)
        Circle()
            .fill(Color.red)
            .frame(width: 0.025 * diameter, height: 0.025 * diameter)

    }
}
