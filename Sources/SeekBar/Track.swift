/*
 Abstract:
 A view represents the default track for a seek bar.
 */

import SwiftUI

struct Track: View {
    let value: CGFloat
    let bounds: ClosedRange<CGFloat>
    
    // TODO: Encapsulate properties related to appearance.
    let activeTrackColor: Color = .accentColor
    let inactiveTrackColor: Color = .gray.opacity(0.3)
    let cornerRadius: CGFloat = 4
    let trackHeight: CGFloat = 4
    
    var body: some View {
        Canvas { context, size in
            // Inactive track
            context.drawTrack(size: size, color: inactiveTrackColor, width: size.width, trackHeight: trackHeight, cornerRadius: cornerRadius)
            
            // Active track
            let activeWidth = width(for: value, in: bounds, with: size.width)
            context.drawTrack(size: size, color: activeTrackColor, width: activeWidth, trackHeight: trackHeight, cornerRadius: cornerRadius)
        }
        .drawingGroup()
    }
    
    /// Calculates the width based on the given value within the specified bounds and availableWidth width.
    ///
    /// - Parameters:
    ///   - value: The value to calculate the width for.
    ///   - bounds: The closed range within which the value should be considered.
    ///   - availableWidth: The total width to scale the calculated width.
    /// - Returns: The calculated width as a CGFloat.
    private func width(for value: CGFloat, in bounds: ClosedRange<CGFloat>, with availableWidth: CGFloat) -> CGFloat {
        let ratio = (value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
        return availableWidth * ratio
    }
}

// MARK: Canvas Context Extenstion

extension GraphicsContext {
    /// Draws a track with the specified size, color, and track dimensions.
    ///
    /// - Parameters:
    ///   - size: The size of the canvas.
    ///   - color: The color of the track.
    ///   - width: The width of the track.
    ///   - trackHeight: The height of the track.
    ///   - cornerRadius: The corner radius of the track.
    func drawTrack(size: CGSize, color: Color, width: CGFloat, trackHeight: CGFloat, cornerRadius: CGFloat) {
        let trackRect = CGRect(
            x: 0,
            y: (size.height - trackHeight) / 2,
            width: width,
            height: trackHeight
        )
        let trackPath = Path { path in
            path.addRoundedRect(in: trackRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        }
        self.fill(trackPath, with: .color(color))
    }
}

// MARK: - Preview

struct Track_Previews: PreviewProvider {
    static let previewName = "Track Preview"
    static var previews: some View {
        Track(value: 0.5, bounds: 0.0...1.0)
            .frame(height: 4)
            .padding()
            .previewDisplayName(previewName)
            .previewLayout(.sizeThatFits)
    }
}
