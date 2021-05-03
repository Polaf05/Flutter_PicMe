import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailerService {
  final String username = 'kevintest5983@gmail.com';
  final String password = 'Polo5983';

  Future sendReciept(String clientEmail, String clientName, String lensmanEmail,
      String lensmanName, String bookingId, DateTime prefereDate) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'PICME')
      ..recipients.add(clientEmail)
      ..subject = 'Booking Reciept'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
