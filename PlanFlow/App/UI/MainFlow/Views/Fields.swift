import SwiftUI

struct StyledTextField: View {
    var label: String
    @Binding var inputText: String
    var textAxis: Axis = .horizontal
    var fieldMaxHeight: CGFloat = 52

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .cwf(Color.black, .tt22)
            TextField("", text: $inputText, axis: textAxis)
                .cwf(Color.black, .tt22)
                .padding(15)
                .frame(maxHeight: fieldMaxHeight)
                .background(Color.white)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
    }
}

struct DropdownTextField: View {
    let label: String
    @Binding var selectedValue: String
    @Binding var isDropdownExpanded: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .cwf(Color.black, .tt22)
            Button(action: {
                withAnimation {
                    isDropdownExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selectedValue)
                        .cwf(Color.black, .tt22)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color.black)
                }
                .padding(15)
                .frame(height: 52)
                .background(Color.white)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
    }
}

struct DateTimePickerSection: View {
    @Binding var isPickerVisible: Bool
    @Binding var selectedValue: Date
    var pickerMode: PickerMode

    enum PickerMode {
        case date
        case time
    }

    var body: some View {
        Group {
            if isPickerVisible {
                if pickerMode == .date {
                    DatePicker("", selection: $selectedValue, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.accent)
                        .accentColor(Color.red)
                        .cornerRadius(15)
                        .transition(.opacity)
                        .padding(5)
                } else {
                    DatePicker("", selection: $selectedValue, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                        .background(Color.accent)
                        .accentColor(Color.red)
                        .cornerRadius(15)
                        .transition(.opacity)
                        .padding(5)
                }
            }
        }
    }
}

struct DateSelectorButton: View {
    let label: String
    @Binding var selectedDate: Date
    @Binding var isPickerVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .cwf(Color.black, .tt22)
            Button(action: { withAnimation { isPickerVisible.toggle() } }) {
                HStack {
                    Text(formattedDate(selectedDate, with: "dd/MM/yy"))
                    Spacer()
                    Image(systemName: "calendar")
                }
                .cwf(Color.black, .tt22)
                .padding(15)
                .frame(maxHeight: 52)
                .background(Color.white)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
    }
}

struct TimeSelectorButton: View {
    let label: String
    @Binding var selectedTime: Date
    @Binding var isPickerVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .cwf(Color.black, .tt22)
            Button(action: {
                withAnimation { isPickerVisible.toggle() }
            }) {
                HStack {
                    Text(formattedDate(selectedTime, with: "HH:mm"))
                    Spacer()
                    Image(systemName: "clock")
                }
                .cwf(Color.black, .tt22)
                .padding(15)
                .frame(maxHeight: 52)
                .background(Color.white)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
    }
}
