// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'find.dart';
import 'message.dart';
import 'dart:convert';

/// A Flutter Driver command that taps on a target widget located by [finder].
class Tap extends CommandWithTarget {
  /// Creates a tap command to tap on a widget located by [finder].
  Tap(SerializableFinder finder, { Duration timeout }) : super(finder, timeout: timeout);

  /// Deserializes this command from the value generated by [serialize].
  Tap.deserialize(Map<String, String> json) : super.deserialize(json);

  @override
  final String kind = 'tap';
}

/// The result of a [Tap] command.
class TapResult extends Result {
  /// Deserializes this result from JSON.
  static TapResult fromJson(Map<String, dynamic> json) {
    return new TapResult();
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};
}


/// A Flutter Driver command that commands the driver to perform a scrolling action.
class Scroll extends CommandWithTarget {
  /// Creates a scroll command that will attempt to scroll a scrollable view by
  /// dragging a widget located by the given [finder].
  Scroll(
    SerializableFinder finder,
    this.dx,
    this.dy,
    this.duration,
    this.frequency, {
    Duration timeout,
  }) : super(finder, timeout: timeout);

  /// Deserializes this command from the value generated by [serialize].
  Scroll.deserialize(Map<String, String> json)
      : this.dx = double.parse(json['dx']),
        this.dy = double.parse(json['dy']),
        this.duration = new Duration(microseconds: int.parse(json['duration'])),
        this.frequency = int.parse(json['frequency']),
        super.deserialize(json);

  /// Delta X offset per move event.
  final double dx;

  /// Delta Y offset per move event.
  final double dy;

  /// The duration of the scrolling action
  final Duration duration;

  /// The frequency in Hz of the generated move events.
  final int frequency;

  @override
  final String kind = 'scroll';

  @override
  Map<String, String> serialize() => super.serialize()..addAll(<String, String>{
    'dx': '$dx',
    'dy': '$dy',
    'duration': '${duration.inMicroseconds}',
    'frequency': '$frequency',
  });
}

class DDrag extends CommandWithTarget {
  /// Creates a drag command that will attempt to drag a dragable view by
  /// dragging a widget located by the given [finder].
  DDrag(
    SerializableFinder finder,
    this.delta,
    this.duration,
    this.frequency, {
    Duration timeout,
  }) : super(finder, timeout: timeout);

  /// Deserializes this command from the value generated by [serialize].
  DDrag.deserialize(Map<String, String> json)
      : this.delta = JSON.decode(json['delta']),
        this.duration = new Duration(microseconds: int.parse(json['duration'])),
        this.frequency = int.parse(json['frequency']),
        super.deserialize(json);

  /// Delta offset per move event.
  final List<dynamic> delta;

  /// The duration of the draging action
  final Duration duration;

  /// The frequency in Hz of the generated move events.
  final int frequency;

  @override
  final String kind = 'drag';

  @override
  Map<String, String> serialize() => super.serialize()..addAll(<String, String>{
    'delta': JSON.encode(delta),
    'duration': '${duration.inMicroseconds}',
    'frequency': '$frequency',
  });
}

/// The result of a [Drag] command.
class DDragResult extends Result {
  /// Deserializes this result from JSON.
  static DDragResult fromJson(Map<String, dynamic> json) {
    return new DDragResult();
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

/// The result of a [Scroll] command.
class ScrollResult extends Result {
  /// Deserializes this result from JSON.
  static ScrollResult fromJson(Map<String, dynamic> json) {
    return new ScrollResult();
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

/// A Flutter Driver command that commands the driver to ensure that the element
/// represented by [finder] has been scrolled completely into view.
class ScrollIntoView extends CommandWithTarget {
  /// Creates this command given a [finder] used to locate the widget to be
  /// scrolled into view.
  ScrollIntoView(SerializableFinder finder, { this.alignment: 0.0, Duration timeout }) : super(finder, timeout: timeout);

  /// Deserializes this command from the value generated by [serialize].
  ScrollIntoView.deserialize(Map<String, String> json)
      : this.alignment = double.parse(json['alignment']),
        super.deserialize(json);

  /// How the widget should be aligned.
  ///
  /// This value is passed to [Scrollable.ensureVisible] as the value of its
  /// argument of the same name.
  ///
  /// Defaults to 0.0.
  final double alignment;

  @override
  final String kind = 'scrollIntoView';

  @override
  Map<String, String> serialize() => super.serialize()..addAll(<String, String>{
    'alignment': '$alignment',
  });
}
