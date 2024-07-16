/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 A set of modifiers to customize the appearance of handle UI elements.
 */

import SwiftUI

public extension View {
    /// Sets the colors for the handle.
    ///
    /// - Parameters:
    ///   - handleColor: The color of the handle.
    ///
    /// - Note: For default color values, see [HandleDefaults](x-source-tag://HandleDefaults)
    func handleColors(handleColor: Color = HandleDefaults.handleColor) -> some View {
        let handleColors = HandleColors(handleColor: handleColor)
        return environment(\.handleColors, handleColors)
    }
    
    /// Sets the dimensions for the handle.
    ///
    /// - Parameters:
    ///   - handleSize: The size of the handle.
    ///
    /// - Note: For default dimensions values, see [HandleDefaults](x-source-tag://HandleDefaults)
    func handleDimensions(handleSize: CGFloat = HandleDefaults.handleSize) -> some View {
        let handleDimensions = HandleDimensions(handleSize: handleSize)
        return environment(\.handleDimensions, handleDimensions)
    }
}
