/*
 Abstract:
 Defines environment keys and their extensions related to track customization.
 */

import SwiftUI

// MARK: - Track Colors Environment Key

struct TrackColorsKey: EnvironmentKey {
    static let defaultValue = TrackColors()
}

extension EnvironmentValues {
    var trackColors: TrackColors {
        get { self[TrackColorsKey.self] }
        set { self[TrackColorsKey.self] = newValue }
    }
}

// MARK: - Track Dimensions Environment Key

struct TrackDimensionsKey: EnvironmentKey {
    static let defaultValue = TrackDimensions()
}

extension EnvironmentValues {
    var trackDimensions: TrackDimensions {
        get { self[TrackDimensionsKey.self] }
        set { self[TrackDimensionsKey.self] = newValue }
    }
}

// MARK: - Track Shape Environment Key

struct TrackShapeKey: EnvironmentKey {
    static let defaultValue = TrackShape.rect
}

extension EnvironmentValues {
    var trackShape: TrackShape {
        get { self[TrackShapeKey.self] }
        set { self[TrackShapeKey.self] = newValue }
    }
}
