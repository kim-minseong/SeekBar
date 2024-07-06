/*
 Abstract:
 This view represents the default handle for a seek bar.
 If the user does not implement a custom handle, this default handle view will be used.
 */

import SwiftUI

struct Handle: View {
    var body: some View {
        Circle()
            .foregroundStyle(.white)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2.5)
    }
}

// MARK: - Preview

struct Handle_Previews: PreviewProvider {
    static let previewName = "Handle Preview"
    static var previews: some View {
        Handle()
            .frame(width: 27, height: 27)
            .previewDisplayName(previewName)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
