import SwiftUI

@available(iOS 16.0, *)
struct TaskAddingScreen: View {
    @Binding var navPath: [Screens]
    private let storage = Storage.shared
    
    @State private var task: Task = Task(id: UUID(), name: "", description: "", planType: "", addSelector: "", controlMethod: "", category: "", date: Date(), time: Date())
    
    @State private var isAddSelectorDropdownExpanded = false
    @State private var isControlMethodDropdownExpanded = false
    @State private var isCategotyDropdownExpanded = false
    @State private var isDatePickerVisible = false
    @State private var isTimePickerVisible = false
    
    var body: some View {
        VStack(spacing: 0) {
            Title(title: "Add a task", withRefreshButton: false, refreshButtonAction: {}, navPath: $navPath)
            
            TaskAddindFields
            
            Spacer()
            
            CancelSaveButtons
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    private var TaskAddindFields: some View {
        ScrollView {
            VStack(spacing: 20) {
                StyledTextField(label: "Task name", inputText: $task.name)
                StyledTextField(label: "Description", inputText: $task.description, textAxis: .vertical, fieldMaxHeight: 156)
                PlanTypeView(planTypeControlMethod: $task.planType, titlesArrray: storage.planTypes)
                if task.planType == storage.planTypes[1] {
                    DropdownTextField(label: "Select a day of week", selectedValue: $task.addSelector, isDropdownExpanded: $isAddSelectorDropdownExpanded)
                    if isAddSelectorDropdownExpanded {
                        Picker("Weekdays", selection: $task.addSelector) {
                            ForEach(storage.weekdays,  id: \.self) { wd in
                                Text(wd).tag(wd)
                                    .foregroundStyle(Color.black)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                } else if task.planType == storage.planTypes[2] {
                    DropdownTextField(label: "Select a week", selectedValue: $task.addSelector, isDropdownExpanded: $isAddSelectorDropdownExpanded)
                    if isAddSelectorDropdownExpanded {
                        Picker("Weeks", selection: $task.addSelector) {
                            ForEach(storage.weeks,  id: \.self) { w in
                                Text(w).tag(w)
                                    .foregroundStyle(Color.black)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                
                DropdownTextField(label: "Select a control method", selectedValue: $task.controlMethod, isDropdownExpanded: $isControlMethodDropdownExpanded)
                if isControlMethodDropdownExpanded {
                    Picker("Category", selection: $task.controlMethod) {
                        ForEach(storage.controlMethods,  id: \.self) { c in
                            Text(c).tag(c)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                DropdownTextField(label: "Category", selectedValue: $task.category, isDropdownExpanded: $isCategotyDropdownExpanded)
                if isCategotyDropdownExpanded && !task.controlMethod.isEmpty {
                    Picker("Category", selection: $task.category) {
                        ForEach(getCategories(for: task.controlMethod), id: \.self) { category in
                            Text(category).tag(category)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                HStack(spacing: 5) {
                    DateSelectorButton(label: "Set a deadline", selectedDate: $task.date, isPickerVisible: $isDatePickerVisible)
                    TimeSelectorButton(label: " ", selectedTime: $task.time, isPickerVisible: $isTimePickerVisible)
                }
                DateTimePickerSection(isPickerVisible: $isDatePickerVisible, selectedValue: $task.date, pickerMode: .date)
                DateTimePickerSection(isPickerVisible: $isTimePickerVisible, selectedValue: $task.time, pickerMode: .time)
                
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
    
    private func getCategories(for method: String) -> [String] {
        switch method {
        case storage.controlMethods[0]:
            return storage.categoriesEisenhower
        case storage.controlMethods[1]:
            return storage.categories8020
        case storage.controlMethods[2]:
            return storage.categoriesTwoLists
        default:
            return []
        }
    }
    
    private var CancelSaveButtons: some View {
        HStack(spacing: 25) {
            MainActionButton(label: "Cancel", padding: 15, font: .tt25, action: cancelButtonAction, backgroundColor: Color.cancelButton)
            MainActionButton(label: "Save", padding: 15, font: .tt25, action: saveButtonAction)
        }
        .padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 35))
    }
    
    private func saveButtonAction() {
        if !task.name.isEmpty && !task.description.isEmpty && !task.controlMethod.isEmpty && !task.category.isEmpty {
            storage.save(task, forKey: TASKS_KEY)
            navPath.removeLast()
        }
    }
    private func cancelButtonAction() {
        navPath.removeLast()
    }
}



#Preview {
    @State var navPath: [Screens] = []
    TaskAddingScreen(navPath: $navPath)
}
