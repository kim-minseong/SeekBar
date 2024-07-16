/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 Defines environment keys and their extensions related to handle customization.
 */

import SwiftUI

// MARK: - Handle Colors Environment Key

struct HandleColorsKey: EnvironmentKey {
    static let defaultValue = HandleColors()
}

extension EnvironmentValues {
    var handleColors: HandleColors {
        get { self[HandleColorsKey.self] }
        set { self[HandleColorsKey.self] = newValue }
    }
}

// MARK: - Handle Dimensions Environment Key

struct HandleDimensionsKey: EnvironmentKey {
    static let defaultValue = HandleDimensions()
}

extension EnvironmentValues {
    var handleDimensions: HandleDimensions {
        get { self[HandleDimensionsKey.self] }
        set { self[HandleDimensionsKey.self] = newValue }
    }
}
