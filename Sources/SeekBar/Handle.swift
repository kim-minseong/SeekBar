/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 This view represents the default handle for a seek bar.
 */

import SwiftUI

struct Handle: View {
    @Environment(\.handleColors) var handleColors
    
    var body: some View {
        Circle()
            .foregroundStyle(handleColors.handleColor)
    }
}

// MARK: - Preview

struct Handle_Previews: PreviewProvider {
    static let previewName = "Handle Preview"
    static var previews: some View {
        Handle()
            .frame(
                width: HandleDefaults.handleSize,
                height: HandleDefaults.handleSize
            )
            .previewDisplayName(previewName)
            .previewLayout(.fixed(width: 50, height: 50))
            .preferredColorScheme(.dark)
    }
}
