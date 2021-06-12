import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailerService {
  final String username = 'kevintest5983@gmail.com';
  final String password = 'Polo5983';

  Future sendEmailReject(
      String clientEmail,
      String clientName,
      String lensmanEmail,
      String lensmanName,
      String contact,
      String feedback) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'PICME')
      ..recipients.add(clientEmail)
      ..subject = 'Request Rejected'
      ..html =
          "<h3>Lensman</h3><p>Name:<b>$lensmanName</b>\nEmail:<b>$lensmanEmail</b>\nFeedback:<b>$feedback</b>\n<h3>Contact Number: </h3>\n<p>$contact</p> \n<h3>Booked by:</h3>\nName:<b>$clientName</b>\nEmail:<b>$clientEmail</b></p>";

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

  Future sendEmailAccept(
      String clientEmail,
      String clientName,
      String lensmanEmail,
      String lensmanName,
      String contact,
      String feedback) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'PICME')
      ..recipients.add(clientEmail)
      ..subject = 'Request Reciept'
      ..html =
          "<h3>Lensman</h3><p>Name:<b>$lensmanName</b>\nEmail:<b>$lensmanEmail</b>\nFeedback:<b>$feedback</b>\n<h3>Contact Number: </h3>\n<p>$contact</p> \n<h3>Booked by:</h3>\nName:<b>$clientName</b>\nEmail:<b>$clientEmail</b></p>";

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
