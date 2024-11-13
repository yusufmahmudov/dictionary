import 'package:language/utils/log_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Caller {
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Log.w("NOT FOUND TEL");
    }
  }

  static Future<void> launchUrlWeb(String url) async {
    final Uri url0 = Uri.parse(url);
    try {
      await launchUrl(url0, mode: LaunchMode.platformDefault);
    } catch (e) {
      Log.e(e);
    }
  }

  static Future<void> makePhoneSMS(String phoneNumber) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: '0118 999 881 999 119 7253',
      queryParameters: <String, String>{
        'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
      },
    );
    await launchUrl(smsLaunchUri);
  }
}
