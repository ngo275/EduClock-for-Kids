import SwiftUI

struct ClockMarkView: View {
    var diameter: CGFloat
    let count: Int
    let mainMarkIndices: [Int]
    let emphasizedLength: CGFloat
    let normalLength: CGFloat
    let emphasizedThickness: CGFloat
    let normalThickness: CGFloat
    let marginRatio: CGFloat = 0.32
    let markColor: Color = Color(hex: "#526F99")
    
    init(diameter: CGFloat) {
        self.diameter = diameter * (1 - marginRatio)
        count = 60
        mainMarkIndices = [0, 15, 30, 45]
        emphasizedLength = 0.03 * diameter
        normalLength = 0.024 * diameter
        emphasizedThickness = 0.010 * diameter
        normalThickness = 0.007 * diameter
    }
    
    func angle(for index: Int) -> CGFloat {
        return 2 * .pi * CGFloat(index) / CGFloat(count)
    }
    
    func xOffset(for index: Int) -> CGFloat {
        let halfWidth = markSize(for: index).width / 2
        return (diameter / 2 - markSize(for: index).height + halfWidth) * cos(angle(for: index) - .pi / 2)
    }
    
    func yOffset(for index: Int) -> CGFloat {
        let halfWidth = markSize(for: index).width / 2
        return (diameter / 2 - markSize(for: index).height + halfWidth) * sin(angle(for: index) - .pi / 2)
    }
    
    func markSize(for index: Int) -> CGSize {
        if mainMarkIndices.contains(index) {
            return CGSize(width: emphasizedThickness, height: emphasizedLength)
        } else if index % 5 == 0 {
            return CGSize(width: emphasizedThickness, height: normalLength)
        } else {
            return CGSize(width: normalThickness, height: normalLength)
        }
    }
    
    func rotationAngle(for index: Int) -> Double {
        return Double(index) / Double(count) * 360.0
    }
    
    var body: some View {
        ForEach(0..<count) { index in
            RoundedRectangle(cornerRadius: 2)
                .fill(markColor)
                .opacity(index % 5 == 0 ? 1 : 0.6) 
                .frame(width: markSize(for: index).width, height: markSize(for: index).height)
                .rotationEffect(Angle(degrees: rotationAngle(for: index)), anchor: .center)
                .offset(x: xOffset(for: index), y: yOffset(for: index))
        }
    }
}
