/*
 Abstract:
 The models that represents the appearance settings for the track.
 */

import SwiftUI

// MARK: - Track Colors

/// A model that represents colors used for the track.
///
/// - Parameters:
///   - activeTrackColor: The color for the active track.
///   - inactiveTrackColor: The color for the inactive track.
///   - bufferedTrackColor: The color for the buffered portion of the track.
struct TrackColors {
    var activeTrackColor: Color = TrackDefaults.activeTrackColor
    var inactiveTrackColor: Color = TrackDefaults.inactiveTrackColor
    var bufferedTrackColor: Color = TrackDefaults.bufferedTrackColor
}

// MARK: - Track Dimensions

/// A model that represents dimensions used for the track.
///
/// - Parameters:
///   - trackHeight: The height of the track.
///   - segmentGap: The gap between segments of the track.
struct TrackDimensions {
    var trackHeight: CGFloat = TrackDefaults.trackHeight
    var segmentGap: CGFloat = TrackDefaults.segmentGap
}

// MARK: - Track Shape

/// A enumeration that represents the shape of the track.
public enum TrackShape {
    /// A rectangular track.
    case rect
    /// A track with rounded corners. The `radius` parameter sepcifies the corner radius.
    case rounded(radius: CGFloat)
}

// MARK: - Track Defaults

/// A structure contains default values for track `colors`, `dimensions`, and `shapes`.
/// - Tag: TrackDefaults
public struct TrackDefaults {
    /// The default color for the active track.
    public static let activeTrackColor: Color = .accentColor
    /// The default color for the  inactive track.
    public static let inactiveTrackColor: Color = .gray.opacity(0.3)
    /// The default color for the buffered portion of the track.
    public static let bufferedTrackColor: Color = .white.opacity(0.6)
    
    /// The default height of the track.
    public static let trackHeight: CGFloat = 4
    /// The default gap between segments of the track.
    public static let segmentGap: CGFloat = 2
    /// The default corner radius of the track.
    public static let cornerRadius: CGFloat = 4
}
