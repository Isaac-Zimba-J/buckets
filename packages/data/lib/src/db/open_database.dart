import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Opens the app's database file in app-private storage (ADR-0003).
BucketsDatabase openBucketsDatabase() =>
    BucketsDatabase(driftDatabase(name: 'buckets'));
