final _digit = RegExp(r'\d');
final _letter = RegExp(r'\p{L}', unicode: true);

/// Hides personal data in [text] before it is logged (AGENTS.md §4).
///
/// Keeps the shape and drops the content: every digit becomes `#`, every
/// letter `x`; spaces and punctuation stay. Pass any raw message text,
/// account number, name or merchant through this.
String redact(String text) =>
    text.replaceAll(_digit, '#').replaceAll(_letter, 'x');
