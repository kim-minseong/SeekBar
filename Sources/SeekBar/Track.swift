/*
 Abstract:
 A view represents the default track for a seek bar.
 */

import SwiftUI

struct Track: View {
    @Environment(\.trackColors) var trackColors
    @Environment(\.trackDimensions) var trackDimensions
    @Environment(\.trackShape) var trackShape
    
    let value: CGFloat
    var bufferedValue: CGFloat?
    let bounds: ClosedRange<CGFloat>
    var timelineSegments: [TimelineSegmentPoint] = []
    
    var body: some View {
        Canvas { context, size in
            // Inactive track
            context.drawLine(
                size: size,
                color: trackColors.inactiveTrackColor,
                width: size.width,
                height: size.height,
                trackShape: trackShape
            )
            
            // Buffer track
            if let bufferedValue {
                let bufferedWidth = width(for: bufferedValue, in: bounds, with: size.width)
                context.drawLine(
                    size: size,
                    color: trackColors.bufferedTrackColor,
                    width: bufferedWidth,
                    height: size.height,
                    trackShape: trackShape
                )
            }
            
            // Active track
            let activeWidth = width(for: value, in: bounds, with: size.width)
            context.drawLine(
                size: size,
                color: trackColors.activeTrackColor,
                width: activeWidth,
                height: size.height,
                trackShape: trackShape
            )
            
            // Draws a gap between timeline segments if any exist.
            if !timelineSegments.isEmpty {
                var segmentContext = context
                segmentContext.blendMode = .clear
                
                for segment in timelineSegments {
                    segmentContext.drawGap(
                        size: size,
                        width: trackDimensions.segmentGap,
                        height: size.height,
                        segment: segment
                    )
                }
            }
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

// MARK: - Canvas Context Extenstion

extension GraphicsContext {
    /// Draws a line with the specified size, color, and dimensions.
    ///
    /// - Parameters:
    ///   - size: The size of the canvas.
    ///   - color: The color of the line.
    ///   - width: The width of the line.
    ///   - height: The height of the line.
    ///   - cornerRadius: The corner radius of the line (optional).
    func drawLine(size: CGSize, color: Color, width: CGFloat, height: CGFloat, trackShape: TrackShape) {
        let lineRect = CGRect(
            x: 0,
            y: (size.height - height) / 2,
            width: width,
            height: height
        )
        let linePath = Path { path in
            if case .rounded(let radius) = trackShape {
                // Add rounded path when cornderRadius value is exists.
                path.addRoundedRect(in: lineRect, cornerSize: CGSize(width: radius, height: radius))
            } else {
                path.addRect(lineRect)
            }
        }
        self.fill(linePath, with: .color(color))
    }
    
    /// Draws a gap at the specified segment position.
    ///
    /// - Parameters:
    ///   - size: The size of the canvas.
    ///   - width: The width of the gap.
    ///   - height: The height of the gap.
    ///   - segment: The segment representing the position of the gap.
    func drawGap(size: CGSize, width: CGFloat, height: CGFloat, segment: TimelineSegmentPoint) {
        let segmentRect = CGRect(
            x: size.width * segment.endPoint,
            y: (size.height - height) / 2,
            width: width,
            height: height
        )
        let segmentPath = Path { path in
            path.addRect(segmentRect)
        }
        self.fill(segmentPath, with: .color(.clear))
    }
}

// MARK: - Preview

struct Track_Previews: PreviewProvider {
    static let trackWithBufferPreviewName = "Track With Buffer Preview"
    static let defaultTrackPreviewName = "Default Track Preview"
    static let trackWithTimelinePreviewName = "Track With Timeline Preview"
    
    static let timelineSegments = [
        TimelineSegmentPoint(name: "Timeline 1", startPoint: 0.0, endPoint: 0.2),
        TimelineSegmentPoint(name: "Timeline 2", startPoint: 0.2, endPoint: 0.6),
        TimelineSegmentPoint(name: "Timeline 3", startPoint: 0.6, endPoint: 0.8),
        TimelineSegmentPoint(name: "Timeline 4", startPoint: 0.8, endPoint: 1.0),
    ]
    
    static var previews: some View {
        Group {
            Track(value: 0.3, bounds: 0.0...1.0)
                .frame(height: 4)
                .padding()
                .previewDisplayName(defaultTrackPreviewName)
                .previewLayout(.sizeThatFits)
            
            Track(value: 0.5, bufferedValue: 0.55, bounds: 0.0...1.0)
                .frame(height: 4)
                .padding()
                .previewDisplayName(trackWithBufferPreviewName)
                .previewLayout(.sizeThatFits)
            
            Track(value: 0.3, bounds: 0.0...1.0, timelineSegments: timelineSegments)
                .frame(height: 4)
                .padding()
                .previewDisplayName(trackWithTimelinePreviewName)
                .previewLayout(.sizeThatFits)
        }
    }
}
