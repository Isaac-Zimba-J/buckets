import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_support.dart';
import '../../helpers.dart';

void main() {
  group('GetStorageSummary', () {
    test('returns the summary', () async {
      final summary = ok(await GetStorageSummary(ScriptedStorageManager())());
      expect(summary.alertCount, 12);
      expect(summary.receiptCount, 3);
      expect(summary.databaseBytes, 204800);
    });
  });

  group('DeleteAllData (R-PRIV-4)', () {
    test('wipes when DELETE is typed', () async {
      final wiper = RecordingDataWiper();
      ok(await DeleteAllData(wiper)('DELETE'));
      expect(wiper.wiped, 1);
    });

    test('does nothing without the exact keyword', () async {
      final wiper = RecordingDataWiper();
      expect(
        await DeleteAllData(wiper)('delete'),
        isErr('delete.notConfirmed'),
      );
      expect(wiper.wiped, 0);
    });
  });

  group('GetDeviceTimeZone', () {
    test('returns the device zone', () async {
      final zone = ok(
        await GetDeviceTimeZone(ScriptedDeviceTimeZone('Europe/Paris'))(),
      );
      expect(zone, 'Europe/Paris');
    });
  });
}
