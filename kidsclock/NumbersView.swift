import SwiftUI

struct HourNumbersView: View {
    var diameter: CGFloat
    var body: some View {
        ForEach(1..<13) { number in
            let numberRadius = diameter * 0.40
            let xOffset = numberRadius * cos(CGFloat((Double(number) - 3) * 30) * .pi / 180)
            let yOffset = numberRadius * sin(CGFloat((Double(number) - 3) * 30) * .pi / 180)
            
            Text("\(number)")
                .font(Font.custom("Michroma", size: 0.07 * diameter))
                .foregroundColor(Color(hex: "#526F99"))
                .offset(x: xOffset, y: yOffset)
        }
    }
}

struct MinuteNumbersView: View {
    var diameter: CGFloat
    
    func xOffset(for minute: Int) -> CGFloat {
        let minuteNumberRadius = diameter * 0.28
        return minuteNumberRadius * cos(CGFloat((Double(minute) / 5.0 - 3) * 30) * .pi / 180)
    }
    
    func yOffset(for minute: Int) -> CGFloat {
        let minuteNumberRadius = diameter * 0.28
        return minuteNumberRadius * sin(CGFloat((Double(minute) / 5.0 - 3) * 30) * .pi / 180)
    }
    
    var body: some View {
        ForEach(Array(1..<61).map { ($0, UUID()) }, id: \.1) { minute, _ in
            Text("\(minute)")
                .font(.system(size: 0.02 * diameter))
                .foregroundColor(Color(hex: "#526F99"))
                .offset(x: xOffset(for: minute), y: yOffset(for: minute))
        }
    }
}
