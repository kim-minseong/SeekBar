/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 The models that represents the appearance settings for the handle.
 */

import SwiftUI

// MARK: - Handle Colors

/// A model that represents colors used for the handle.
///
/// - Parameters:
///   - handleColor: The color of the handle.
struct HandleColors {
    var handleColor: Color = HandleDefaults.handleColor
}

// MARK: - Handle Dimensions

/// A model that represents dimensions used for the handle.
///
/// - Parameters:
///   - handleSize: The size of the handle.
struct HandleDimensions {
    var handleSize: CGFloat = HandleDefaults.handleSize
}

// MARK: - Handle Defaults

/// A structure contains default values for handle `colors`, `dimensions`.
/// - Tag: HandleDefaults
public struct HandleDefaults {
    /// The default color for the handle.
    public static let handleColor: Color = .white
    
    /// The default size for the handle.
    public static let handleSize: CGFloat = 14
}
