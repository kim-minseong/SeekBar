/*
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
    ///   - segmentGap: The gap between segments of the track.
    ///
    /// - Note: For default dimension values, see [TrackDefaults](x-source-tag://TrackDefaults)
    func trackDimensions(
        trackHeight: CGFloat = TrackDefaults.trackHeight,
        segmentGap: CGFloat = TrackDefaults.segmentGap
    ) -> some View {
        let trackDimensions = TrackDimensions(
            trackHeight: trackHeight,
            segmentGap: segmentGap
        )
        return environment(\.trackDimensions, trackDimensions)
    }
    
    /// Sets the shape for the track.
    ///
    /// - Parameters:
    ///   - trackShape: The shape of the track.
    ///
    /// - Note: For default shape values, see [TrackDefaults](x-source-tag://TrackDefaults)
    func trackShape(trackShape: TrackShape = .rect) -> some View {
        return environment(\.trackShape, trackShape)
    }
}
