/*
 Abstract:
 This view represents the default seek bar.
 */

import SwiftUI

public struct SeekBar: View {
    @Environment(\.trackDimensions) private var trackDimensions
    @Environment(\.handleDimensions) private var handleDimensions
    @Environment(\.interactive) private var interactive
    @Environment(\.displayMode) private var displayMode
    @Environment(\.trackAction) private var trackAction
    
    @Binding private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let onEditingChanged: (Bool) -> Void
    private var onSegmentChanged: (TimelineSegmentPoint) -> Void = { _ in }
    
    let timelineSegments = [
        TimelineSegmentPoint(name: "Timeline 1", startPoint: 0.0, endPoint: 0.2),
        TimelineSegmentPoint(name: "Timeline 2", startPoint: 0.2, endPoint: 0.6),
        TimelineSegmentPoint(name: "Timeline 3", startPoint: 0.6, endPoint: 0.8),
        TimelineSegmentPoint(name: "Timeline 4", startPoint: 0.8, endPoint: 1.0),
    ]
    
    @State private var dragStartOffset: CGFloat = 0
    @State private var currentSegment: TimelineSegmentPoint?
    
    private var seekBarMaxHeight: CGFloat {
        return max(trackDimensions.trackHeight, handleDimensions.handleSize)
    }
    
    private var isInteractiveWithTrack: Bool {
        return interactive == .track
    }
    
    private var isDisplayOnlyTrack: Bool {
        return displayMode == .trackOnly
    }
    
    private var isActionMoveWithValue: Bool {
        return trackAction == .moveWithValue
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let handleSize = handleDimensions.handleSize
            let availableWidth = proxy.size.width - handleSize
            
            ZStack(alignment: .leading) {
                Track(value: value, bounds: bounds, timelineSegments: timelineSegments)
                    .frame(height: trackDimensions.trackHeight)
                    .allowsHitTesting(isInteractiveWithTrack || isActionMoveWithValue)
                    .gesture(isActionMoveWithValue ? moveWithValueDragGesture(availableWidth: availableWidth) : nil)
                    .gesture(!isActionMoveWithValue ? dragGesture(availableWidth: availableWidth) : nil)
                
                Handle()
                    .frame(width: handleSize, height: handleSize)
                    .opacity(isDisplayOnlyTrack ? 0 : 1)
                    .offset(x: calculateOffset(for: value, within: bounds, with: availableWidth))
                    .allowsHitTesting(!isInteractiveWithTrack || isActionMoveWithValue)
                    .gesture(!isDisplayOnlyTrack ? dragGesture(availableWidth: availableWidth): nil)
            }
        }
        .frame(height: seekBarMaxHeight)
    }
    
    private func moveWithValueDragGesture(availableWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { dragValue in
                onEditingChanged(true)
                if abs(dragValue.startLocation.x - dragValue.location.x) > 0 {
                    value = normalizedValue(for: dragValue.startLocation.x, within: bounds, with: availableWidth)
                    updateValueWithDrag(dragValue: dragValue, availableWidth: availableWidth)
                    checkSegmentChange(dragValue: dragValue, availableWidth: availableWidth)
                }
            }.onEnded { _ in
                onEditingChanged(false)
            }
    }
    
    private func dragGesture(availableWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { dragValue in
                onEditingChanged(true)
                updateValueWithDrag(dragValue: dragValue, availableWidth: availableWidth)
                checkSegmentChange(dragValue: dragValue, availableWidth: availableWidth)
            }
            .onEnded { _ in
                dragStartOffset = 0
                onEditingChanged(false)
            }
    }
    
    private func checkSegmentChange(dragValue: DragGesture.Value, availableWidth: CGFloat) {
        guard !timelineSegments.isEmpty else { return }
        if let current = timelineSegments.first(where: { $0.startPoint <= value && value <= $0.endPoint }) {
            if let currentSegment = currentSegment {
                if current != currentSegment {
                    self.currentSegment = current
                    onSegmentChanged(current)
                }
            } else {
                currentSegment = current
                onSegmentChanged(current)
            }
        }
    }
    
    /// Calculates the offset for the handle based on the current value, bounds, and available width.
    ///
    /// - Parameters:
    ///   - value: The current value to be represented by the handle.
    ///   - bounds: The range within which the value is constrained.
    ///   - availableWidth: The total available width for the offset calculation.
    ///
    /// - Returns: The calculated offset as a `CGFloat`.
    private func calculateOffset(for value: CGFloat, within bounds: ClosedRange<CGFloat>, with availableWidth: CGFloat) -> CGFloat {
        return (value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound) * availableWidth
    }
    
    /// Calculates the normalized value based on the given position within the specified bounds and available width.
    ///
    /// - Parameters:
    ///   - position: The position to be normalized.
    ///   - bounds: The range within which the value is constrained.
    ///   - availableWidth: The total width to scale the normalized value.
    ///
    /// - Returns: The calculated normalized value as a `CGFloat`.
    private func normalizedValue(for position: CGFloat, within bounds: ClosedRange<CGFloat>, with availableWidth: CGFloat) -> CGFloat {
        let clampedPosition = min(max(0, position), availableWidth)
        let normalized = clampedPosition / availableWidth
        return normalized * (bounds.upperBound - bounds.lowerBound) + bounds.lowerBound
    }
    
    /// The drag change event by updating the current value based on the drag gesture's position.
    ///
    /// - Parameters:
    ///   - dragValue: The value representing the drag gesture's current state.
    ///   - availableWidth: The total available width for the offset calculation.
    private func updateValueWithDrag(dragValue: DragGesture.Value, availableWidth: CGFloat) {
        if dragStartOffset == 0 {
            // Calculate the initial offset to ensure smooth handle movement
            dragStartOffset = dragValue.startLocation.x - calculateOffset(for: value, within: bounds, with: availableWidth)
        }
        
        // Calculate the new handle position within the available width
        value = normalizedValue(for: dragValue.location.x - dragStartOffset, within: bounds, with: availableWidth)
    }
}
