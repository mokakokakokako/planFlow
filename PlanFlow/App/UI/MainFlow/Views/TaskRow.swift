import SwiftUI

struct TaskRow: View {
    @Binding var task: Task
    var onComplete: () -> Void

    var body: some View {
        HStack {
            Button(action: {
                task.isCompleted.toggle()
                onComplete()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(task.isCompleted ? Color.background : Color.gray)
            }
            .buttonStyle(.plain)

            Text(task.name)
                .cwf(task.isCompleted ? Color.gray : Color.black, .tt16)
            Spacer()
            Text("(\(task.controlMethod))")
                .cwf(Color.background, .tt8)

        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(12)
    }
}
