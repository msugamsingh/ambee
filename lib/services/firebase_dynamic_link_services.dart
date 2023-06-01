import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

/// A service class for handling Firebase Dynamic Links.
class FirebaseDynamicLinkServices {

  // Reference
  // https://aeweather.page.link/?link=https://www.getambee.com?lat=12.97&lon=77.59&apn=com.ambee.ambee&afl=https://www.getambee.com&efr=1

  // we have to encode the link if it has more than 1 param
  // https://aeweather.page.link/?link=https%3A%2F%2Fwww.getambee.com%3Flat%3D12.97%26lon%3D77.59&apn=com.ambee.ambee&afl=https://www.getambee.com&efr=1


  /// Retrieves the initial dynamic link when the app is launched from a deep link.
  ///
  /// Returns the latitude and longitude values parsed from the deep link, if available.
  /// Returns null if the initial link is null or does not contain latitude and longitude parameters.
  static Future<(double? lat, double? lon)?> initialLink(context) async {
    final PendingDynamicLinkData? initialLink =
    await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      final double? lat = double.tryParse(deepLink.queryParameters['lat'] ?? '');
      final double? lon = double.tryParse(deepLink.queryParameters['lon'] ?? '');
      if (lat == null || lon == null) {
        return null;
      }
      return (lat, lon);
    } else {
      return null;
    }
  }

  /// Listens for incoming dynamic links while the app is running.
  ///
  /// The provided [callback] function will be called with the received dynamic link data.
  static Future<void> onReceiveDynamicLink(
      void Function(PendingDynamicLinkData)? callback) async {
    FirebaseDynamicLinks.instance.onLink.listen(callback);
  }
}