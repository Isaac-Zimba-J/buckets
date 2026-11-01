import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Bucket bucket(
  String name, {
  BucketKind kind = BucketKind.custom,
  bool archived = false,
}) => ok(
  Bucket.create(
    id: name,
    name: name,
    kind: kind,
    color: BucketColor.goal,
    accountId: 'a',
    archived: archived,
  ),
);

void main() {
  group('Bucket', () {
    test('rejects a blank name', () {
      expect(
        Bucket.create(
          id: 'b',
          name: '',
          kind: BucketKind.custom,
          color: BucketColor.goal,
          accountId: 'a',
        ),
        isErr('name.blank'),
      );
    });

    test('R-BUCKET-2 emergency and long-term are always protected', () {
      expect(bucket('E', kind: BucketKind.emergency).isProtected, isTrue);
      expect(bucket('L', kind: BucketKind.longTerm).isProtected, isTrue);
      expect(bucket('S', kind: BucketKind.shortTerm).isProtected, isFalse);
    });
  });

  group('R-BUCKET-1 default buckets', () {
    final defaults = Bucket.defaults(
      ids: SequentialIds(),
      spendingAccountId: 'spend',
      savingsAccountId: 'save',
    );

    test('creates the five default buckets in order with their colours', () {
      expect(
        [for (final b in defaults) (b.name, b.kind, b.color, b.sortOrder)],
        [
          ('Living', BucketKind.living, BucketColor.living, 0),
          ('Guilt-free', BucketKind.guiltFree, BucketColor.fun, 1),
          ('Emergency', BucketKind.emergency, BucketColor.emergency, 2),
          ('Short-term', BucketKind.shortTerm, BucketColor.short, 3),
          ('Long-term', BucketKind.longTerm, BucketColor.long, 4),
        ],
      );
      expect(defaults.map((b) => b.id).toSet(), hasLength(5));
    });

    test('R-BUCKET-3 Living and Guilt-free live in the spending account', () {
      expect(
        [for (final b in defaults) b.accountId],
        [
          'spend',
          'spend',
          'save',
          'save',
          'save',
        ],
      );
    });

    test('pass the bucket rules', () {
      expect(ok(BucketRules.validate(defaults)), defaults);
    });
  });

  group('R-BUCKET-5 bucket rules', () {
    final living = bucket('Living', kind: BucketKind.living);
    final fun = bucket('Guilt-free', kind: BucketKind.guiltFree);

    test('names are unique case-insensitively among active buckets', () {
      expect(
        BucketRules.validate([living, fun, bucket('Laptop'), bucket('LAPTOP')]),
        isErr('buckets.duplicateName'),
      );
      expect(
        BucketRules.validate([
          living,
          fun,
          bucket('Laptop'),
          bucket('laptop', archived: true),
        ]),
        isA<Ok<List<Bucket>>>(),
      );
    });

    test('exactly one Living bucket', () {
      expect(BucketRules.validate([fun]), isErr('buckets.livingCount'));
      expect(
        BucketRules.validate([
          living,
          fun,
          bucket('Living 2', kind: BucketKind.living),
        ]),
        isErr('buckets.livingCount'),
      );
    });

    test('exactly one Guilt-free bucket', () {
      expect(BucketRules.validate([living]), isErr('buckets.guiltFreeCount'));
    });
  });
}
