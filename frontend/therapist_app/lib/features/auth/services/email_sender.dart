import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender {
  static Future<void> sendEmail({
    required String recipientEmail,
    required String subject,
    required String body,
  }) async {
    String smtpUsername = dotenv.get("SMTPUSERNAME", fallback: "");
    String smtpPassword = dotenv.get("SMTPPASSWORD", fallback: "");
    int smtpPort = int.parse(dotenv.get("SMTPPORT", fallback: ""));
    String smtpAddress = dotenv.get("SMTPADDRESS", fallback: "");

    final smtpServer = SmtpServer(
      smtpAddress, // Replace with your SMTP server address
      username: smtpUsername,
      password: smtpPassword,
      port:
          smtpPort, // Replace with your SMTP server port (usually 465 for SSL)
      ssl: true,
    );

    final message = Message()
      ..from = Address(smtpUsername, 'FocusMi')
      ..recipients.add(recipientEmail)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      // Handle any errors that occurred during sending the email
      print('Error sending email: $e');
    }
  }
}
