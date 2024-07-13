/*
 Abstract:
 An extension for the `Comparable` protocol that provides a method to clamp values within a specified range.
 */

import Foundation

extension Comparable {
    /// Clamps the value within the provided bounds.
    ///
    /// - Parameters:
    ///   - bounds: The range within which to clamp the value.
    /// - Returns: The clamped value, which will be within the bounds.
    func clamped(in bounds: ClosedRange<Self>) -> Self {
        min(max(self, bounds.lowerBound), bounds.upperBound)
    }
}
