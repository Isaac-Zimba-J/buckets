import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

final _notLetterOrSpace = RegExp(r'[^\p{L}\s]', unicode: true);
final _spaces = RegExp(r'\s+');

/// A normalized counterparty that merchant rules match on (R-SPEND-3).
final class MerchantKey with Equatable {
  const MerchantKey._(this.value);

  /// Lower-cases [counterparty] and strips digits and punctuation.
  static Result<MerchantKey> create(String counterparty) {
    final value = counterparty
        .toLowerCase()
        .replaceAll(_notLetterOrSpace, ' ')
        .replaceAll(_spaces, ' ')
        .trim();
    return value.isEmpty
        ? const Err(
            ValidationFailure(
              'merchantKey.empty',
              'The merchant name has no letters.',
            ),
          )
        : Ok(MerchantKey._(value));
  }

  /// The normalized key.
  final String value;

  @override
  List<Object?> get props => [value];
}
