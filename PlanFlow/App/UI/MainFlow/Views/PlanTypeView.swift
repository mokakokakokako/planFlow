import SwiftUI

struct PlanTypeView: View {
    @Binding var planTypeControlMethod: String
    var font: FontBuilder = .tt15
    let titlesArrray: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(titlesArrray, id: \.self) { pT in
                Button(action: {
                    planTypeControlMethod = pT
                }) {
                    Text(pT)
                        .foregroundColor(planTypeControlMethod == pT ?  Color.white : Color.black)
                        .customFont(font)
                        .minimumScaleFactor(0.5)
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                        .frame(maxHeight: 35)
                        .background(planTypeControlMethod == pT ?  Color.accentAdc : Color.white)
                        .cornerRadius(8)
                }
                if pT != titlesArrray.last { Spacer() }
            }
        }
    }
}
