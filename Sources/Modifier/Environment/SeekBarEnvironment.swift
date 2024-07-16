/*
 See the LICENSE.txt file for this project licensing information.
 
 Abstract:
 Defines environment keys and their extensions related to seekbar customization.
 */

import SwiftUI

// MARK: - SeekBar Interactive Environment Key

/// A enumeration that represents the interactive type of a SeekBar.
public enum SeekBarInteractive {
    /// Interaction with the track of the `SeekBar`, allowing drag only on the track.
    case track
    /// Interaction with the handle of the `SeekBar`, allowing drag only on the handle.
    case handle
}

struct SeekBarInteractiveKey: EnvironmentKey {
    static let defaultValue = SeekBarInteractive.track
}

extension EnvironmentValues {
    var interactive: SeekBarInteractive {
        get { self[SeekBarInteractiveKey.self] }
        set { self[SeekBarInteractiveKey.self] = newValue }
    }
}

// MARK: - SeekBar Display mode Environment Key

/// A enumeration that represents the display type of a SeekBar.
public enum SeekBarDisplayMode {
    /// Display both the track and the handle.
    case `default`
    /// Display only the track without the handle.
    case trackOnly
}

struct SeekBarDisplayModeKey: EnvironmentKey {
    static let defaultValue = SeekBarDisplayMode.default
}

extension EnvironmentValues {
    var displayMode: SeekBarDisplayMode {
        get { self[SeekBarDisplayModeKey.self] }
        set { self[SeekBarDisplayModeKey.self] = newValue }
    }
}

// MARK: - SeekBar Track action Environment Key

/// A enumeration that represents the action when click track of a SeekBar.
public enum SeekBarTrackAction {
    /// The SeekBar's value changes based on the gesture starting on the track.
    case moveWithValue
    /// No action is performed when clicking on the track.
    case none
}

struct SeekBarTrackActionKey: EnvironmentKey {
    static let defaultValue = SeekBarTrackAction.none
}

extension EnvironmentValues {
    var trackAction: SeekBarTrackAction {
        get { self[SeekBarTrackActionKey.self] }
        set { self[SeekBarTrackActionKey.self] = newValue }
    }
}
