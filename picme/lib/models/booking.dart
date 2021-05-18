class Booking {
  final String clientId;
  final String lensmanId;
  final String clientContact;
  final String clientEmail;
  final String clientName;
  final String lensmanName;
  final String lensmanEmail;
  final String request;
  final dynamic date;
  final String status;
  final String id;

  Booking(
      {this.clientId,
      this.lensmanId,
      this.clientContact,
      this.clientEmail,
      this.clientName,
      this.lensmanName,
      this.lensmanEmail,
      this.request,
      this.date,
      this.status,
      this.id});
}
