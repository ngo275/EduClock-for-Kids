import SwiftUI

struct ContentView: View {
    @State var hour: Int = Calendar.current.component(.hour, from: Date())
    @State var minute: Int = Calendar.current.component(.minute, from: Date())
    @State var second: Int = Calendar.current.component(.second, from: Date())
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    //    init() {
    //            for family in UIFont.familyNames {
    //                for name in UIFont.fontNames(forFamilyName: family) {
    //                    print(name)
    //                }
    //            }
    //        }
    
    var body: some View {
        ClockView(hour: $hour, minute: $minute, second: $second)
            .onReceive(timer) { _ in
                let now = Date()
                self.hour = Calendar.current.component(.hour, from: now)
                self.minute = Calendar.current.component(.minute, from: now)
                self.second = Calendar.current.component(.second, from: now)
            }
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
    }
}

#Preview {
    ContentView()
}
