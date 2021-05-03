import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailerService {
  final String username = 'kevintest5983@gmail.com';
  final String password = 'Polo5983';

  Future sendReciept(
      String clientEmail,
      String clientName,
      String lensmanEmail,
      String lensmanName,
      String bookingId,
      String request,
      DateTime prefereDate) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'PICME')
      ..recipients.add(clientEmail)
      ..subject = 'Booking Reciept'
      ..html =
          "<h1>ID: $bookingId</h1>\n<h3>Lensman</h3><p>Name:<b>$lensmanName</b>\nEmail:<b>$lensmanEmail</b>\nPrefered Date:<b>$prefereDate</b>\n<h3>Request</h3>\n<p>$request</p> \n<h3>Booked by:</h3>\nName:<b>$clientName</b>\nEmail:<b>$clientEmail</b></p>";

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

  Future sendRequest(
      String clientEmail,
      String clientName,
      String lensmanEmail,
      String lensmanName,
      String bookingId,
      String request,
      DateTime prefereDate) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'PICME')
      ..recipients.add(clientEmail)
      ..subject = 'Booking Reciept'
      ..html =
          "<h1>ID: $bookingId</h1>\n<h3>CLient</h3><p>Name:<b>$clientName</b>\nEmail:<b>$clientEmail</b>\nPrefered Date:<b>$prefereDate</b>\n<h3>Request</h3>\n<p>$request</p> \n<h3>Booked to:</h3>\nName:<b>$lensmanName</b>\nEmail:<b>$lensmanEmail</b></p>";

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
