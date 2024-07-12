/*
 Abstract:
 
 */

import Foundation

/// A segment of a timeline, defined by its name and start time.
///
/// This structure provide segment information.
///
/// - Parameters:
///   - name: The name of the segment.
///   - startTime: The starting time of the segment in seconds. For instance, if the start time is 0:30, it is represented as 30 seconds.
///
///  ```swift
///  // start time is represents to 0:30
///  TimelineSegment(name: "Timeline 1", startTime: 30)
///
///  // start time is represents to 2:40
///  TimelineSegment(name: "Timeline 2", startTime: 160)
///  ```
public struct TimelineSegment {
    let name: String
    let startTime: Float
}

/// A segment of a timeline represented by its position within a view, defined by its name, starting point, and ending point.
///
/// This structure is used internally by the library to represent segments in terms of their positions within the view.
/// It is mapped from `TimelineSegment` to handle the graphical representation.
///
/// - Parameters:
///   - name: The name of the segment.
///   - startPoint: The starting position of the segment as a fraction of the view's width (0.0 to 1.0).
///   - endPoint: The ending position of the segment as a fraction of the view's width (0.0 to 1.0).
struct TimelineSegmentPoint {
    let name: String
    let startPoint: CGFloat
    let endPoint: CGFloat
}
