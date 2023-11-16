import SwiftUI

struct ClockView: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    let marginRatio: CGFloat = 0.1
    
    var timeString: String {
        String(format: "%02d:%02d", hour, minute)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let limitingSize = isLandscape ? geometry.size.height : geometry.size.width
            let margin = limitingSize * marginRatio
            let diameter = limitingSize - margin
            let radius = diameter / 2
            
            let labelHeight: CGFloat = 40.0
            let labelWidth: CGFloat = 200
            
            ZStack {
                Color(hex: "#FFF").ignoresSafeArea()
                Text(timeString)
                    .frame(width: labelWidth, height: labelHeight)
                    .font(.custom("Outfit-Thin_Bold", size: diameter * 0.07))
                    .foregroundColor(Color(hex: "#646E82"))
                    .position(
                        x: isLandscape ? (geometry.size.width - diameter) * 0.4 : geometry.size.width/2,
                        y: isLandscape ? (geometry.size.height - diameter) * 0.9 : geometry.size.height / 2 + radius + margin
                    )
                
                ZStack {
                    // Outer Circle with Drop Shadow
                    Circle()
                        .fill(Color(hex: "#FFF"))
                        .shadow(color: .gray.opacity(0.4), radius: 8, x: 5, y: 5)
                        .frame(width: diameter, height: diameter)
                    
                    ColorSegmentedCircle(diameter: diameter)
                    
                    // Hour Numbers
                    HourNumbersView(diameter: diameter)
                    
                    // Minute Numbers
                    MinuteNumbersView(diameter: diameter)
                    
                    ClockMarkView(diameter: diameter)
                    
                    HourHand(diameter: diameter, hour: hour, minute: minute)
                    MinuteHand(diameter: diameter, minute: minute)
                    
                    Circle()
                        .fill(Color(hex: "#646E82"))
                        .frame(width: 0.05 * diameter, height: 0.05 * diameter)
                        .rotationEffect(.degrees(Double(hour % 12) * 30 + Double(minute) * 0.5))
                    
                    SecondHand(diameter: diameter, second: second)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 0.025 * diameter, height: 0.025 * diameter)
                        .rotationEffect(.degrees(Double(hour % 12) * 30 + Double(minute) * 0.5))
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
            }    
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    @State static var hour = 10
    @State static var minute = 10
    @State static var second = 0
    
    static var previews: some View {
        ClockView(hour: $hour, minute: $minute, second: $second)
    }
}
