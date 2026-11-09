import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:buckets_ui_kit/gallery.dart';
import 'package:flutter/material.dart';

void main() => runApp(const GalleryApp());

/// The component gallery: pick a page, flip the theme (ADR-0005).
class GalleryApp extends StatefulWidget {
  /// Creates the app.
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  ThemeMode _mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Buckets ui_kit',
    theme: BucketsTheme.light,
    darkTheme: BucketsTheme.dark,
    themeMode: _mode,
    home: _Index(mode: _mode, onMode: (m) => setState(() => _mode = m)),
  );
}

class _Index extends StatelessWidget {
  const _Index({required this.mode, required this.onMode});

  final ThemeMode mode;
  final ValueChanged<ThemeMode> onMode;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.bk.colors.bg,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(BkSpacing.s4),
        children: [
          BkSegmented<ThemeMode>(
            options: const [
              BkSegment(ThemeMode.system, 'System'),
              BkSegment(ThemeMode.light, 'Light'),
              BkSegment(ThemeMode.dark, 'Dark'),
            ],
            selected: mode,
            onChanged: onMode,
          ),
          const BkGap(BkSpacing.s4),
          BkListGroup(
            children: [
              for (final (title, page) in galleryPages)
                BkListRow(
                  title: title,
                  chevron: true,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => _Page(title: title, page: page),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _Page extends StatelessWidget {
  const _Page({required this.title, required this.page});

  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.bk.colors.bg,
    body: SafeArea(
      child: Column(
        children: [
          BkTopBar(
            leading: BkIconButton(
              icon: BkIcons.back,
              semanticLabel: 'Back',
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: title,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(BkSpacing.s4),
              child: page,
            ),
          ),
        ],
      ),
    ),
  );
}
