import 'package:buckets/routing/routes.dart';

/// The scheme of notification and launch payloads (ARCHITECTURE §11).
const deepLinkScheme = 'buckets';

/// The router location for a `buckets://` [link] (R-NOTIF-4). Anything it
/// does not recognise opens Home.
String locationForDeepLink(Uri link) {
  if (link.scheme != deepLinkScheme) return Routes.home;
  final segments = link.pathSegments.where((s) => s.isNotEmpty).toList();
  return switch ((link.host, segments)) {
    ('payday', [final id]) => Routes.payday(id),
    ('alert', [final id]) => Routes.alert(id),
    ('checkin', []) => Routes.checkIn,
    ('plan', ['wish', final id]) => Routes.planWish(id),
    ('plan', ['bills']) => Routes.planBills,
    ('plan', ['bills', final id, 'pay']) => Routes.billPay(id),
    ('bucket', [final id]) => Routes.bucket(id),
    _ => Routes.home,
  };
}

/// [locationForDeepLink] for a raw payload string, which may not parse.
String locationForPayload(String payload) {
  final uri = Uri.tryParse(payload);
  return uri == null ? Routes.home : locationForDeepLink(uri);
}
