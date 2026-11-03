import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets_data/buckets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final zone = await DeviceTimeZone.load();
  runApp(
    ProviderScope(
      overrides: [localTimeZoneProvider.overrideWithValue(zone)],
      child: const BucketsApp(),
    ),
  );
}

/// Root widget. Blank until the Logic complete gate opens.
class BucketsApp extends StatelessWidget {
  /// Creates the root widget.
  const new({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Scaffold());
}
