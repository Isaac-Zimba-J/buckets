/// Rules for clearing data (SCREENS 27, R-PRIV-3, R-PRIV-4). The deletions
/// themselves are use cases over the repositories and ports; these are the
/// pure checks around them.
abstract final class DataPrivacyRules {
  /// The exact word the user types to confirm wiping all data (R-PRIV-4).
  static const deleteKeyword = 'DELETE';

  /// Whether [typed] confirms a full wipe: the keyword exactly, ignoring
  /// surrounding spaces.
  static bool confirmsDelete(String typed) => typed.trim() == deleteKeyword;
}
