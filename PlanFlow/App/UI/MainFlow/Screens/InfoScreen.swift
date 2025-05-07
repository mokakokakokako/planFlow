import SwiftUI

@available(iOS 16.0, *)
struct InfoScreen: View {
    @Binding var navPath: [Screens]
    private let storage = Storage.shared
    let id: UUID
    
    @State private var task: Task = Task(id: UUID(), name: "", description: "", planType: "", addSelector: "", controlMethod: "", category: "", date: Date(), time: Date())
    
    @State private var controlMethod: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Title(title: task.name, withRefreshButton: true, refreshButtonAction: { controlMethod = "" }, navPath: $navPath)
            
            VStack(alignment: .leading, spacing: 20) {
                
                InfoDetail(title: "Method", text: task.controlMethod)
                InfoDetail(title: "Category", text: task.category)
                InfoDetail(title: "Description", text: task.description)
                HStack {
                    InfoDetail(title: "Deadline", text: formattedDate(task.date, with: "dd/MM/yy"))
                    InfoDetail(title: "Deadline", text: formattedDate(task.time, with: "HH:mm"))
                }
            }
            .padding(EdgeInsets(top: 23, leading: 13, bottom: 23, trailing: 13))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(20)
            
            
            Spacer()
            
        }
        .onAppear {
            guard let t: Task = storage.getObjectById(id, forKey: TASKS_KEY) else { return }
            task = t
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}


struct InfoDetail: View {
    
    let title: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .cwf(Color.accentAdc, .tt12)
            Text(text)
                .cwf(Color.black, .tt18)
        }
    }
}


#Preview {
    @State var navPath: [Screens] = []
    InfoScreen(navPath: $navPath, id: UUID())
}
