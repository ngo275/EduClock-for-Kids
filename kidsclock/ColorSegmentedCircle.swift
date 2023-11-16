import SwiftUI

struct ColorSegmentedCircle: View {
    let segmentColors: [Color] = [
        Color(hex: "#EEB760"),
        Color(hex: "#FAE471"),
        Color(hex: "#F7DD66"),
        Color(hex: "#98C569"),
        Color(hex: "#A8D1BF"),
        Color(hex: "#CBCCE8"),
        Color(hex: "#B9C6E4"),
        Color(hex: "#96A3CD"),
        Color(hex: "#BF98C0"),
        Color(hex: "#D5BAD5"),
        Color(hex: "#D22F52"),
        Color(hex: "#DC654E")
    ]
    let diameter: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let outerRadius = geometry.size.width * 0.24
            let innerRadius = geometry.size.width * 0.12
            
            ForEach(0..<12) { index in
                let startAngleValue = Double(index) * 30 - 60
                let endAngleValue = Double(index + 1) * 30 - 60
                let startAngle = Angle(degrees: startAngleValue)
                let endAngle = Angle(degrees: endAngleValue)
                
                Path { path in
                    path.addArc(center: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
                    path.closeSubpath()
                }
                .fill(self.segmentColors[index])
                
                // Add the numbers
                Text("\(index + 1)")
                    .font(UIDevice.current.userInterfaceIdiom == .phone ? .headline : .title)
                    .foregroundColor(Color.white)
                    .position(
                        CGPoint(
                            x: center.x + CGFloat(cos((startAngleValue + 15) * .pi / 180)) * (outerRadius + innerRadius) / 2,
                            y: center.y + CGFloat(sin((startAngleValue + 15) * .pi / 180)) * (outerRadius + innerRadius) / 2
                        )
                    )
            }
        }
        .frame(width: diameter, height: diameter)
    }
    
    init(diameter: CGFloat = 600) {
        self.diameter = diameter
    }
}
