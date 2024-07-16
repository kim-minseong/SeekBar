/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 A set of modifiers to customize the appearance of track UI elements.
 */

import SwiftUI

public extension View {
    /// Sets the colors for the track.
    ///
    /// - Parameters:
    ///   - activeTrackColor: The color of the active part of the track.
    ///   - inactiveTrackColor: The color of the inactive part of the track.
    ///   - bufferedTrackColor: The color of the buffered part of the track.
    ///
    /// - Note: For default color values, see [TrackDefaults](x-source-tag://TrackDefaults)
    func trackColors(
        activeTrackColor: Color = TrackDefaults.activeTrackColor,
        inactiveTrackColor: Color = TrackDefaults.inactiveTrackColor,
        bufferedTrackColor: Color = TrackDefaults.bufferedTrackColor
    ) -> some View {
        let trackColors = TrackColors(
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            bufferedTrackColor: bufferedTrackColor
        )
        return environment(\.trackColors, trackColors)
    }
    
    /// Sets the dimensions for the track.
    ///
    /// - Parameters:
    ///   - trackHeight: The height of the track.
    ///   - inactiveTrackCornerRadius: The corner radius of the inacitve track.
    ///   - activeTrackCornerRadius: The corner radius of the active track.
    ///   - bufferedTrackCornerRadius: The corner radius of the buffered track
    ///
    /// - Note: For default dimension values, see [TrackDefaults](x-source-tag://TrackDefaults)
    func trackDimensions(
        trackHeight: CGFloat = TrackDefaults.trackHeight,
        inactiveTrackCornerRadius: CGFloat = 0,
        activeTrackCornerRadius: CGFloat = 0,
        bufferedTrackCornerRadius: CGFloat = 0
    ) -> some View {
        let trackDimensions = TrackDimensions(
            trackHeight: trackHeight,
            inactiveTrackCornerRadius: inactiveTrackCornerRadius,
            activeTrackCornerRadius: activeTrackCornerRadius,
            bufferedTrackCornerRadius: bufferedTrackCornerRadius
        )
        return environment(\.trackDimensions, trackDimensions)
    }
}
