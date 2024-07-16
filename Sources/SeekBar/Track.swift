/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 A view represents the default track for a seek bar.
 */

import SwiftUI

struct Track: View {
    @Environment(\.trackColors) var trackColors
    @Environment(\.trackDimensions) var trackDimensions
    
    let value: CGFloat
    let bufferedValue: CGFloat
    let bounds: ClosedRange<CGFloat>
    
    var body: some View {
        GeometryReader { proxy in
            let availableWidth = proxy.size.width
            ZStack(alignment: .leading) {
                
                // Inactive Track.
                RoundedRectangle(cornerRadius: trackDimensions.inactiveTrackCornerRadius)
                    .foregroundStyle(trackColors.inactiveTrackColor)
                    .frame(width: availableWidth)
                
                // Buffered Track.
                RoundedRectangle(cornerRadius: trackDimensions.bufferedTrackCornerRadius)
                    .foregroundStyle(trackColors.bufferedTrackColor)
                    .frame(width: calculatePosition(for: bufferedValue, within: bounds, with: availableWidth))
                
                // Active Track.
                RoundedRectangle(cornerRadius: trackDimensions.activeTrackCornerRadius)
                    .foregroundStyle(trackColors.activeTrackColor)
                    .frame(width: calculatePosition(for: value, within: bounds, with: availableWidth))
                
            }
            .clipShape(RoundedRectangle(cornerRadius: trackDimensions.inactiveTrackCornerRadius))
            .drawingGroup()
        }
    }
}

// MARK: - Preview

struct Track_Previews: PreviewProvider {
    static let trackWithBufferPreviewName = "Track With Buffer Preview"
    static let defaultTrackPreviewName = "Default Track Preview"
    
    static var previews: some View {
        Group {
            Track(value: 0.3, bufferedValue: 0, bounds: 0.0...1.0)
                .frame(height: 4)
                .padding()
                .previewDisplayName(defaultTrackPreviewName)
                .previewLayout(.sizeThatFits)
            
            Track(value: 0.5, bufferedValue: 0.55, bounds: 0.0...1.0)
                .frame(height: 4)
                .padding()
                .previewDisplayName(trackWithBufferPreviewName)
                .previewLayout(.sizeThatFits)
        }
        .preferredColorScheme(.dark)
    }
}
