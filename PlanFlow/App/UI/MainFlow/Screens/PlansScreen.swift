import SwiftUI

@available(iOS 16.0, *)
struct PlansScreen: View {
    @Binding var navPath: [Screens]
    private let storage = Storage.shared
    
    @State private var tasks: [Task] = [
        Task(id: UUID(), name: "", description: "", planType: "", addSelector: "", controlMethod: "", category: "", date: Date(), time: Date()),
    ]
    
    @State private var planType: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Title(title: "Plan", withRefreshButton: true, refreshButtonAction: { planType = "" }, navPath: $navPath)
            
            PlanTypeView(planTypeControlMethod: $planType, font: .tt19, titlesArrray: storage.planTypes)
                .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
            
            PlansLists
            
            Spacer()
            
        }
        .onAppear {
            tasks = storage.getObjects(forKey: TASKS_KEY)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    private var PlansLists: some View {
        ScrollView {
            VStack(spacing: 20) {
                let filteredTasks = tasks.filter { $0.planType == planType }

                switch planType {
                case "Daily plan":
                    let activeIndices = filteredTasks.enumerated().compactMap { index, task in
                        !task.isCompleted ? tasks.firstIndex(where: { $0.id == task.id }) : nil
                    }
                    let completedIndices = filteredTasks.enumerated().compactMap { index, task in
                        task.isCompleted ? tasks.firstIndex(where: { $0.id == task.id }) : nil
                    }

                    if !activeIndices.isEmpty {
                        ForEach(activeIndices, id: \.self) { index in
                            TaskRow(task: $tasks[index]) {
                                updateAndSave(task: tasks[index])
                            }
                            .onTapGesture {
                                navPath.append(.info(tasks[index].id))
                            }
                        }
                        
                    }

                    if !completedIndices.isEmpty {
                        Text("Completed")
                            .cwf(Color.accentAdc, .tt16)
                        ForEach(completedIndices, id: \.self) { index in
                            TaskRow(task: $tasks[index]) {
                                updateAndSave(task: tasks[index])
                            }
                            .onTapGesture {
                                navPath.append(.info(tasks[index].id))
                            }
                        }
                    }

                case "Weekly plan", "Monthly plan":
                    let groupedTasks = groupTasksByCategory(filteredTasks)
                    ForEach(groupedTasks.keys.sorted(), id: \.self) { group in
                        let tasksForGroup = groupedTasks[group] ?? []

                        let activeIndices = tasksForGroup.enumerated().compactMap { index, task in
                            !task.isCompleted ? tasks.firstIndex(where: { $0.id == task.id }) : nil
                        }
                        let completedIndices = tasksForGroup.enumerated().compactMap { index, task in
                            task.isCompleted ? tasks.firstIndex(where: { $0.id == task.id }) : nil
                        }

                        Text(group)
                            .cwf(Color.black, .tt22)

                        ForEach(activeIndices, id: \.self) { index in
                            TaskRow(task: $tasks[index]) {
                                updateAndSave(task: tasks[index])
                            }
                            .onTapGesture {
                                navPath.append(.info(tasks[index].id))
                            }
                        }

                        if !completedIndices.isEmpty {
                            Text("Completed")
                                .cwf(Color.accentAdc, .tt16)
                            ForEach(completedIndices, id: \.self) { index in
                                TaskRow(task: $tasks[index]) {
                                    updateAndSave(task: tasks[index])
                                }
                                .onTapGesture {
                                    navPath.append(.info(tasks[index].id))
                                }
                            }
                        }
                    }

                default:
                    EmptyView()
                }
            }
            .animation(.easeInOut, value: tasks)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20)
    }

    private func groupTasksByCategory(_ tasks: [Task]) -> [String: [Task]] {
        var groupedTasks: [String: [Task]] = [:]
        for task in tasks {
            let group = task.addSelector
            if groupedTasks[group] == nil {
                groupedTasks[group] = []
            }
            groupedTasks[group]?.append(task)
        }
        return groupedTasks
    }
    private func updateAndSave(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            storage.updateObjectById(task.id, with: task, forKey: TASKS_KEY)
        }
    }
}



#Preview {
    @State var navPath: [Screens] = []
    PlansScreen(navPath: $navPath)
}
