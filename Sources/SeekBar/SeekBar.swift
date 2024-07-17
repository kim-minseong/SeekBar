/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 This view represents the default seek bar.
 */

import SwiftUI

/// A control for selecting a value from a bounded linear range of values, similar to SwiftUI's `Slider`.
///
/// The` SeekBar` component is designed to facilitate easy display and manipulation of progress in video or audio players,
/// and partially replace some functionalities of the simple SwiftUI `Slider`.
///
/// ```swift
/// @State private var progress = 0.5
///
/// var body: some View {
///     SeekBar(value: $progress)
/// }
///```
///
/// You can also use a `step` parameter to increment or decrement the value by the specified step within the bounds.
///
/// ```swift
/// @State private var progress = 0.0
///
/// var body: some View {
///     SeekBar(
///         value: $progress,
///         in: 0...1,
///         step: 0.2
///     )
/// }
/// ```
///
/// Additionally, the `onEditingChanged` closure allows you to perform various animations or change the state.
/// 
/// ```swift
/// @State private var progress = 0.5
/// @State private var isEditing = false
///
/// var body: some View {
///     SeekBar(
///         value: $progress,
///         onEditingChange = { editing in
///             withAnimation {
///                 isEditing = editing
///             }
///         }
///     )
///     .handleDimension(
///         handleSize: isEditing ? 16 : 12
///     )
/// }
///
public struct SeekBar: View {
    @Environment(\.trackDimensions) private var trackDimensions
    @Environment(\.handleDimensions) private var handleDimensions
    @Environment(\.interactive) private var interactive
    @Environment(\.displayMode) private var displayMode
    @Environment(\.trackAction) private var trackAction
    
    @Binding private var value: CGFloat
    private let bufferedValue: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let step: CGFloat
    private let onEditingChanged: (Bool) -> Void
    
    @State private var dragStartOffset: CGFloat = 0
    
    public var body: some View {
        GeometryReader { proxy in
            let handleSize = handleDimensions.handleSize
            let availableWidth = proxy.size.width - handleSize
            
            ZStack(alignment: .leading) {
                Track(value: value, bufferedValue: bufferedValue, bounds: bounds)
                    .frame(height: trackDimensions.trackHeight)
                    .allowsHitTesting(allowsTrackHitTesting)
                    .gesture(dragGesture(availableWidth: availableWidth))
                
                Handle()
                    .frame(width: handleSize, height: handleSize)
                    .opacity(isDisplayOnlyTrack ? 0 : 1)
                    .offset(x: calculatePosition(for: value, within: bounds, with: availableWidth))
                    .allowsHitTesting(allowsHandleHitTesting)
                    .gesture(dragGesture(availableWidth: availableWidth))
            }
        }
        .frame(height: seekBarMaxHeight)
    }
    
    /// Creates a `DragGesture` to handle dragging interactions.
    ///
    /// - Parameter availableWidth: The available width for calculating drag positions.
    private func dragGesture(availableWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { dragValue in
                onEditingChanged(true)
                
                // Check if there is a significant change in drag position.
                if abs(dragValue.startLocation.x - dragValue.location.x) > 0 {
                    // Updates the value if moveWithValue action mode requires immediate value change.
                    if isActionMoveWithValue {
                        value = normalizedValue(for: dragValue.startLocation.x, within: bounds, with: availableWidth, step: step)
                    }
                    // Updates the position based on drag movement.
                    updateValueWithDrag(dragValue: dragValue, availableWidth: availableWidth)
                }
            }
            .onEnded { _ in
                // Resets the drag start offset.
                dragStartOffset = 0
                onEditingChanged(false)
            }
    }
    
    /// The drag change event by updating the current value based on the drag gesture's position.
    ///
    /// - Parameters:
    ///   - dragValue: The value representing the drag gesture's current state.
    ///   - availableWidth: The total available width for the offset calculation.
    private func updateValueWithDrag(dragValue: DragGesture.Value, availableWidth: CGFloat) {
        if dragStartOffset == 0 {
            // Calculate the initial offset to ensure smooth handle movement
            dragStartOffset = dragValue.startLocation.x - calculatePosition(for: value, within: bounds, with: availableWidth)
        }
        
        // Calculate the new handle position within the available width
        value = normalizedValue(for: dragValue.location.x - dragStartOffset, within: bounds, with: availableWidth, step: step)
    }
}

// MARK: - Helper stored property

extension SeekBar {
    /// Calculates the maximum height of the seek bar, considering both the track height and handle size.
    private var seekBarMaxHeight: CGFloat {
        return max(trackDimensions.trackHeight, handleDimensions.handleSize)
    }
    
    /// Determines if the seek bar is interactive with the track based on the current environment setting.
    private var isInteractiveWithTrack: Bool {
        return interactive == .track
    }
    
    /// Determines if the seek bar displays only the track, without interactive handles.
    private var isDisplayOnlyTrack: Bool {
        return displayMode == .trackOnly
    }
    
    /// Determines if the seek bar action mode involves moving the value along the select position.
    private var isActionMoveWithValue: Bool {
        return trackAction == .moveWithValue
    }
    
    /// Determines if the track allows hit testing based on the handle size and interactive mode.
    private var allowsTrackHitTesting: Bool {
        return handleDimensions.handleSize == 0 || (isInteractiveWithTrack || isActionMoveWithValue)
    }
    
    /// Determines if the handle allows hit testing based on the interactive mode.
    private var allowsHandleHitTesting: Bool {
        return !isInteractiveWithTrack || isActionMoveWithValue
    }
}

// MARK: - Initializers

extension SeekBar {
    /// Creates a `SeekBar` to select a value from a given range based on the specified step.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of allowable values. Defaults to `0...1`
    ///   - step: The distance by which the valid value changes. Defaults to `0.000001`
    ///   - onEditingChanged: A closure that is called when editing begins and ends.
    public init<V>(
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        step: V.Stride = 0.000001,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        self._value = Binding(
            get: { CGFloat(value.wrappedValue.clamped(in: bounds)) },
            set: { value.wrappedValue = V($0) }
        )
        self.bufferedValue = 0
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)
        self.onEditingChanged = onEditingChanged
    }
    
    /// Creates a `SeekBar` to select a value from a given range based on the specified step and provide a buffered value.
    /// suitable for scenarios like video or audio players where buffered values are used.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bufferedValue: The buffered value within `bounds`.
    ///   - bounds: The range of allowable values. Defaults to `0...1`
    ///   - step: The distance by which the valid value changes. Defaults to `0.000001`
    ///   - onEditingChanged: A closure that is called when editing begins and ends.
    public init<V>(
        value: Binding<V>,
        bufferedValue: V,
        in bounds: ClosedRange<V> = 0...1,
        step: V.Stride = 0.000001,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        self._value = Binding(
            get: { CGFloat(value.wrappedValue.clamped(in: bounds)) },
            set: { value.wrappedValue = V($0) }
        )
        self.bufferedValue = CGFloat(bufferedValue)
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)
        self.onEditingChanged = onEditingChanged
    }
}
