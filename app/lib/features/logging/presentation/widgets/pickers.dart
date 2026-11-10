import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// What was bought: the default categories as chips.
class CategoryChips extends StatelessWidget {
  /// Creates the chips.
  const CategoryChips({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  /// The chosen category.
  final Category? selected;

  /// Called with the tapped category.
  final ValueChanged<Category> onChanged;

  @override
  Widget build(BuildContext context) => BkChipGroup<Category>(
    options: [for (final c in Category.defaults) BkChipOption(c, c.name)],
    selected: selected,
    onChanged: onChanged,
  );
}

/// Which bucket paid: every bucket as a chip with its dot.
class BucketChips extends ConsumerWidget {
  /// Creates the chips.
  const BucketChips({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  /// The chosen bucket's ID.
  final String? selected;

  /// Called with the tapped bucket's ID.
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buckets =
        ref.watch(bucketAccountsControllerProvider).value?.buckets ?? [];
    return BkChipGroup<String>(
      options: [
        for (final b in buckets)
          BkChipOption(b.bucketId, b.name, dot: b.color.bk),
      ],
      selected: selected,
      onChanged: onChanged,
    );
  }
}

/// A small overline label above a picker.
class FieldLabel extends StatelessWidget {
  /// Creates the label.
  const FieldLabel(this.text, {super.key});

  /// The label.
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: BkSpacing.s4, bottom: BkSpacing.s2),
    child: Text(
      text,
      style: context.bk.type.callout.copyWith(
        color: context.bk.colors.ink,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
