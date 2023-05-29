import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamicLinkServices {

  static Future<(double? lat, double? lon)?> initialLink(context) async {
    final PendingDynamicLinkData? initialLink =
    await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      final double? lat = double.tryParse(deepLink.queryParameters['lat'] ??
          deepLink.queryParameters['latitude'] ??
          '');
      final double? lon = double.tryParse(deepLink.queryParameters['lon'] ??
          deepLink.queryParameters['longitude'] ??
          '');
      return (lat, lon);
    } else {
      return null;
    }
  }

  static Future<void> onReceiveDynamicLink(
      void Function(PendingDynamicLinkData)? callback) async {
    FirebaseDynamicLinks.instance.onLink.listen(callback);
  }
}