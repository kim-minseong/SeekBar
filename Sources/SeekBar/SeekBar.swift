/*
 Abstract:
 This view represents the default seek bar.
 */

import SwiftUI

public struct SeekBar: View {
    // The current value represented by the seek bar, bound to an external state.
    @Binding var value: CGFloat
    
    // The offset of the handle when the drag gesture starts, used to calculate
    // the new position during dragging.
    @State private var dragStartOffset: CGFloat = 0
    // A state variable that tracks whether the handle is currently being dragged.
    @GestureState private var isDragging: Bool = false
    
    let step: CGFloat
    let bounds: ClosedRange<CGFloat>
    let onEditingChanged: (Bool) -> Void
    
    var handleWidth: CGFloat = 27
    
    public var body: some View {
        GeometryReader { proxy in
            let availableWidth = proxy.size.width - handleWidth
            
            ZStack(alignment: .leading) {
                Track(value: value, bounds: bounds)
                
                Handle()
                    .frame(width: handleWidth, height: handleWidth)
                    .offset(x: calculateOffset(for: value, within: bounds, with: availableWidth))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { dragValue in
                                handleDragChange(dragValue: dragValue, availableWidth: availableWidth)
                            }
                            .onEnded { _ in
                                dragStartOffset = 0
                            }
                    )
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
        let steppedValue = (round(normalized * (bounds.upperBound - bounds.lowerBound) / step) * step) + bounds.lowerBound
        value = steppedValue
    }
}
