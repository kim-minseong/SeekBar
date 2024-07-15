/*
 Abstract:
 The math module unit test.
 */

import XCTest
@testable import SeekBar

final class MathTests: XCTestCase {
    
    // MARK: - Calculate position
    
    func testCalculatePosition_valueZero() {
        // Given
        let value: CGFloat = 0.0
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        
        // When
        let position = calculatePosition(for: value, within: bounds, with: availableWidth)
        
        // Then
        XCTAssertEqual(position, 0, accuracy: 0.000001)
    }
    
    func testCalculatePosition_valueMid() {
        // Given
        let value: CGFloat = 0.5
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        
        // When
        let position = calculatePosition(for: value, within: bounds, with: availableWidth)
        
        // Then
        XCTAssertEqual(position, 50, accuracy: 0.000001)
    }
    
    func testCalculatePosition_valueMax() {
        // Given
        let value: CGFloat = 1.0
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        
        // When
        let position = calculatePosition(for: value, within: bounds, with: availableWidth)
        
        // Then
        XCTAssertEqual(position, 100, accuracy: 0.000001)
    }
    
    func testCalculatePosition_valueNegativeBounds() {
        // Given
        let value: CGFloat = -0.5
        let bounds: ClosedRange<CGFloat> = -1...1
        let availableWidth: CGFloat = 100
        
        // When
        let position = calculatePosition(for: value, within: bounds, with: availableWidth)
        
        // Then
        XCTAssertEqual(position, 25, accuracy: 0.000001)
    }
    
    // MARK: - Normalized value
    
    func testNormalizedValue_positionZero() {
        // Given
        let position: CGFloat = 0.0
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        let step: CGFloat = 0.1
        
        // When
        let value = normalizedValue(for: position, within: bounds, with: availableWidth, step: step)
        
        // Then
        XCTAssertEqual(value, 0, accuracy: 0.000001)
    }
    
    func testNormalizedValue_positionMid() {
        // Given
        let position: CGFloat = 50.0
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        let step: CGFloat = 0.1
        
        // When
        let value = normalizedValue(for: position, within: bounds, with: availableWidth, step: step)
        
        // Then
        XCTAssertEqual(value, 0.5, accuracy: 0.000001)
    }
    
    func testNormalizedValue_positionMax() {
        // Given
        let position: CGFloat = 100.0
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        let step: CGFloat = 0.1
        
        // When
        let value = normalizedValue(for: position, within: bounds, with: availableWidth, step: step)
        
        // Then
        XCTAssertEqual(value, 1.0, accuracy: 0.000001)
    }
    
    func testNormalizedValue_withStep() {
        // Given
        let position: CGFloat = 75.0
        let bounds: ClosedRange<CGFloat> = 0...1
        let availableWidth: CGFloat = 100
        let step: CGFloat = 0.2
        
        // When
        let value = normalizedValue(for: position, within: bounds, with: availableWidth, step: step)
        
        // Then
        XCTAssertEqual(value, 0.8, accuracy: 0.000001)
    }
    
    func testNormalizedValue_negativeBounds() {
        // Given
        let position: CGFloat = 25.0
        let bounds: ClosedRange<CGFloat> = -1...1
        let availableWidth: CGFloat = 100
        let step: CGFloat = 0.1
        
        // When
        let value = normalizedValue(for: position, within: bounds, with: availableWidth, step: step)
        
        // Then
        XCTAssertEqual(value, -0.5, accuracy: 0.000001)
    }
    
    func testNormalizedValue_nonZeroBounds() {
        // Given
        let position: CGFloat = 50.0
        let bounds: ClosedRange<CGFloat> = 1...2
        let availableWidth: CGFloat = 100
        let step: CGFloat = 0.1
        
        // When
        let value = normalizedValue(for: position, within: bounds, with: availableWidth, step: step)
        
        // Then
        XCTAssertEqual(value, 1.5, accuracy: 0.000001)
    }
    
    // MARK: - Clamped
    
    func testClamped_valueWithinBounds() {
        // Given
        let value: CGFloat = 0.5
        let bounds: ClosedRange<CGFloat> = 0...1
        
        // When
        let clampedValue = value.clamped(in: bounds)
        
        // Then
        XCTAssertEqual(clampedValue, 0.5)
    }
    
    func testClamped_valueBelowLowerBound() {
        // Given
        let value: CGFloat = -0.5
        let bounds: ClosedRange<CGFloat> = 0...1
        
        // When
        let clampedValue = value.clamped(in: bounds)
        
        // Then
        XCTAssertEqual(clampedValue, 0)
    }
    
    func testClamped_valueAboveUpperBound() {
        // Given
        let value: CGFloat = 1.5
        let bounds: ClosedRange<CGFloat> = 0...1
        
        // When
        let clampedValue = value.clamped(in: bounds)
        
        // Then
        XCTAssertEqual(clampedValue, 1)
    }
}
