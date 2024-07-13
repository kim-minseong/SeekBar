/*
 Abstract:
 This view represents the default seek bar.
 */

import SwiftUI

public struct SeekBar: View {
    @Environment(\.trackDimensions) private var trackDimensions
    @Environment(\.handleDimensions) private var handleDimensions
    
    // The current value represented by the seek bar, bound to an external state.
    @Binding private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let onEditingChanged: (Bool) -> Void
    
    @State private var dragStartOffset: CGFloat = 0
    @GestureState private var isDragging: Bool = false
    
    private var seekBarMaxHeight: CGFloat {
        max(trackDimensions.trackMaxHeight, handleDimensions.handleSize)
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let handleSize = handleDimensions.handleSize
            let availableWidth = proxy.size.width - handleSize
            
            Track(value: value, bounds: bounds)
            
            Handle()
                .frame(width: handleSize, height: handleSize)
                .offset(x: calculateOffset(for: value, within: bounds, with: availableWidth))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isDragging) { _, state, _ in
                            state = true
                        }
                        .onChanged { dragValue in
                            handleDragChange(dragValue: dragValue, availableWidth: availableWidth)
                            onEditingChanged(true)
                        }
                        .onEnded { _ in
                            dragStartOffset = 0
                            onEditingChanged(false)
                        }
                )
        }
        .frame(height: seekBarMaxHeight)
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
    
    /// Handles the drag change event by updating the current value based on the drag gesture's position.
    ///
    /// - Parameters:
    ///   - dragValue: The value representing the drag gesture's current state.
    ///   - availableWidth: The total available width for the offset calculation.
    private func handleDragChange(dragValue: DragGesture.Value, availableWidth: CGFloat) {
        if dragStartOffset == 0 {
            // Calculate the initial offset to ensure smooth handle movement
            dragStartOffset = dragValue.startLocation.x - calculateOffset(for: value, within: bounds, with: availableWidth)
        }
        
        // Calculate the new handle position within the available width
        let newValue = min(max(0, dragValue.location.x - dragStartOffset), availableWidth)
        let normalized = newValue / availableWidth
        let normalizedValue = normalized * (bounds.upperBound - bounds.lowerBound) + bounds.lowerBound
        value = normalizedValue
    }
}
