import SwiftUI

func formattedDate(_ date: Date, with format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}
