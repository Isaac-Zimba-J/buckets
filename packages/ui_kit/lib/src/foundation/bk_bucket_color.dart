import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// Bucket colours, so features never pick hex values. The app maps its
/// bucket kinds to these in view models.
enum BkBucketColor {
  /// Living.
  living,

  /// Guilt-free.
  fun,

  /// Emergency.
  emergency,

  /// Short-term.
  short,

  /// Long-term.
  long,

  /// Goals.
  goal,

  /// Family.
  family,

  /// Business (Restock).
  business;

  /// The colour in the active theme.
  ///
  /// ```dart
  /// BkBucketColor.living.resolve(context)
  /// ```
  Color resolve(BuildContext context) {
    final c = context.bk.colors;
    return switch (this) {
      living => c.bucketLiving,
      fun => c.bucketFun,
      emergency => c.bucketEmergency,
      short => c.bucketShort,
      long => c.bucketLong,
      goal => c.bucketGoal,
      family => c.bucketFamily,
      business => c.bucketBusiness,
    };
  }
}
