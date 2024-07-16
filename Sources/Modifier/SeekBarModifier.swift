/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 A set of modifiers to customize seekbar UI elements.
 */

import SwiftUI

public extension View {
    /// Sets the interactive behavior of a SeekBar within the view hierarchy.
    ///
    /// - Parameter interactive: The interactive type  to set for the SeekBar. Defaults to SeekBarInteractive.track
    func seekBarInteractive(with interactive: SeekBarInteractive) -> some View {
        return environment(\.interactive, interactive)
    }
    
    /// Sets the display mode of a SeekBar within the view hierarchy.
    ///
    /// - Parameter displayMode: The display mode to set for the SeekBar. Defaults to SeekBarDisplayMode.default
    func seekBarDisplay(with displayMode: SeekBarDisplayMode) -> some View {
        return environment(\.displayMode, displayMode)
    }
    
    /// Sets the track action of a SeekBar within the view hierarchy.
    ///
    /// - Parameter action: The action to perform when clicking on the SeekBar track. Defaults to SeekBarTrackAction.none
    func seekBarTrackAction(with action: SeekBarTrackAction) -> some View {
        return environment(\.trackAction, action)
    }
}
