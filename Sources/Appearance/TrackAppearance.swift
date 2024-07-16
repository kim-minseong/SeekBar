/*
 See the LICENSE.txt file for this project licensing information.
 
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
///   - inactiveTrackCornerRadius: The corner radius of the inacitve track.
///   - activeTrackCornerRadius: The corner radius of the active track.
///   - bufferedTrackCornerRadius: The corner radius of the buffered track
struct TrackDimensions {
    var trackHeight: CGFloat = TrackDefaults.trackHeight
    var inactiveTrackCornerRadius: CGFloat = 0
    var activeTrackCornerRadius: CGFloat = 0
    var bufferedTrackCornerRadius: CGFloat = 0
}

// MARK: - Track Defaults

/// A structure contains default values for track `colors`, `dimensions`, and `shapes`.
/// - Tag: TrackDefaults
public struct TrackDefaults {
    /// The default color for the active track.
    public static let activeTrackColor: Color = Color(red: 201, green: 201, blue: 201)
    /// The default color for the  inactive track.
    public static let inactiveTrackColor: Color = .white.opacity(0.2)
    /// The default color for the buffered portion of the track.
    public static let bufferedTrackColor: Color = .white.opacity(0.3)
    
    /// The default height of the track.
    public static let trackHeight: CGFloat = 4
}
