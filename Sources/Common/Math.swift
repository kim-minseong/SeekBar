/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 The set of utility functions for mathematical calculations for related to SeekBar.
 */

import CoreFoundation

/// Calculates the position based on the given value within the specified bounds and available width.
///
/// - Parameters:
///   - value: The value to calculate the position for.
///   - bounds: The closed range within which the value is constrained.
///   - availableWidth: The total width available for the calculation.
///
/// - Returns: The calculated position as a CGFloat.
func calculatePosition(for value: CGFloat, within bounds: ClosedRange<CGFloat>, with availableWidth: CGFloat) -> CGFloat {
    let ratio = (value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
    return availableWidth * ratio
}

/// Calculates the normalized value based on the given position within the specified bounds and available width.
///
/// - Parameters:
///   - position: The position to be normalized.
///   - bounds: The range within which the value is constrained.
///   - availableWidth: The total width to scale the normalized value.
///   - step: The step value to snap the value to.
///
/// - Returns: The calculated normalized value as a `CGFloat`.
func normalizedValue(for position: CGFloat, within bounds: ClosedRange<CGFloat>, with availableWidth: CGFloat, step: CGFloat) -> CGFloat {
    let clampedPosition = min(max(0, position), availableWidth)
    let normalized = clampedPosition / availableWidth
    let steppedValue = (round(normalized * (bounds.upperBound - bounds.lowerBound) / step) * step) + bounds.lowerBound
    return steppedValue
}

extension Comparable {
    /// Clamps the value within the provided bounds.
    ///
    /// - Parameters:
    ///   - bounds: The range within which to clamp the value.
    ///
    /// - Returns: The clamped value, which will be within the bounds.
    func clamped(in bounds: ClosedRange<Self>) -> Self {
        min(max(self, bounds.lowerBound), bounds.upperBound)
    }
}
