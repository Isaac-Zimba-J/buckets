/// Throws a [RangeError] unless [confidence] is from 0 to 1.
///
/// Confidence is produced by our own parsers, so a bad value is a
/// programmer error, not user input.
void checkConfidence(double confidence) {
  if (confidence < 0 || confidence > 1) {
    throw RangeError.range(confidence, 0, 1, 'confidence');
  }
}
