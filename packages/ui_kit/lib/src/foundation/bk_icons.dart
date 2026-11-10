import 'package:flutter/painting.dart';

extension on Path {
  void line(double x1, double y1, double x2, double y2) => this
    ..moveTo(x1, y1)
    ..lineTo(x2, y2);

  void poly(List<double> xy, {bool close = false}) {
    moveTo(xy[0], xy[1]);
    for (var i = 2; i < xy.length; i += 2) {
      lineTo(xy[i], xy[i + 1]);
    }
    if (close) this.close();
  }

  void circle(double cx, double cy, double r) =>
      addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));

  void rrect(double l, double t, double r, double b, double radius) =>
      addRRect(RRect.fromLTRBR(l, t, r, b, Radius.circular(radius)));
}

/// The Buckets icon set: outline glyphs on a 24 grid, drawn by `BkIcon`
/// with a 1.75 stroke and round caps (DESIGN_SYSTEM iconography).
enum BkIcons {
  /// Back (top bar).
  back,

  /// Close (sheets, flows).
  close,

  /// Notifications (greeting header).
  notifications,

  /// Add / log (floating button).
  plus,

  /// Row disclosure.
  chevronRight,

  /// Done, passed check.
  check,

  /// Warning banner.
  warning,

  /// Info banner.
  info,

  /// Home tab.
  home,

  /// Goals tab.
  goals,

  /// Plan tab.
  plan,

  /// Me tab.
  me,

  /// Scan a receipt.
  camera,

  /// Locked (payday not done).
  lock,

  /// Timers (cooling off, snooze).
  clock,

  /// Paste from the clipboard (proof SMS).
  paste,

  /// Proven paydays in a row.
  streak;

  /// The glyph in 24 × 24 units.
  Path get path => switch (this) {
    back => Path()..poly([15, 5, 8, 12, 15, 19]),
    close =>
      Path()
        ..line(6, 6, 18, 18)
        ..line(18, 6, 6, 18),
    notifications =>
      Path()
        ..moveTo(6, 16.5)
        ..lineTo(6, 10.5)
        ..arcToPoint(const Offset(18, 10.5), radius: const Radius.circular(6))
        ..lineTo(18, 16.5)
        ..lineTo(19.5, 18)
        ..lineTo(4.5, 18)
        ..close()
        ..line(10, 21, 14, 21),
    plus =>
      Path()
        ..line(12, 5, 12, 19)
        ..line(5, 12, 19, 12),
    chevronRight => Path()..poly([9, 5, 16, 12, 9, 19]),
    check => Path()..poly([5, 12.5, 10, 17.5, 19, 7]),
    warning =>
      Path()
        ..poly([12, 3.5, 21.5, 20, 2.5, 20], close: true)
        ..line(12, 9.5, 12, 13.5)
        ..line(12, 16.75, 12, 16.76),
    info =>
      Path()
        ..circle(12, 12, 9)
        ..line(12, 11, 12, 16.5)
        ..line(12, 7.75, 12, 7.76),
    home =>
      Path()..poly([
        3.5, 10.5, 12, 3.5, 20.5, 10.5, 20.5, 20, 3.5, 20, //
      ], close: true),
    goals =>
      Path()
        ..line(5.5, 21, 5.5, 3.5)
        ..poly([5.5, 4, 18.5, 4, 15.5, 8.5, 18.5, 13, 5.5, 13], close: true),
    plan =>
      Path()
        ..rrect(5, 4, 19, 21, 2.5)
        ..line(9, 9.5, 15, 9.5)
        ..line(9, 13, 15, 13)
        ..line(9, 16.5, 12.5, 16.5),
    me =>
      Path()
        ..circle(12, 8, 4)
        ..moveTo(4.5, 20.5)
        ..arcToPoint(
          const Offset(19.5, 20.5),
          radius: const Radius.circular(7.5),
        )
        ..close(),
    camera =>
      Path()
        ..poly([
          3, 8, 7.5, 8, 9, 5, 15, 5, 16.5, 8, 21, 8, 21, 19, 3, 19, //
        ], close: true)
        ..circle(12, 13, 3.5),
    lock =>
      Path()
        ..rrect(5, 10.5, 19, 20.5, 2.5)
        ..moveTo(8, 10.5)
        ..lineTo(8, 7.5)
        ..arcToPoint(const Offset(16, 7.5), radius: const Radius.circular(4))
        ..lineTo(16, 10.5),
    clock =>
      Path()
        ..circle(12, 12, 9)
        ..poly([12, 7, 12, 12, 15.5, 14]),
    paste =>
      Path()
        ..rrect(6, 4.5, 18, 20.5, 2)
        ..poly([9.5, 3, 14.5, 3, 14.5, 6, 9.5, 6], close: true),
    streak =>
      Path()
        ..moveTo(12, 3)
        ..cubicTo(13, 6, 17, 8, 17, 13)
        ..arcToPoint(const Offset(7, 13), radius: const Radius.circular(5))
        ..cubicTo(7, 11, 8, 10, 9, 9)
        ..cubicTo(9, 11, 10, 12, 11, 12)
        ..cubicTo(11, 8, 10, 6, 12, 3)
        ..close(),
  };
}
