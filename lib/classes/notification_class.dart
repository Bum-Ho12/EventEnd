class RequestClass {
  final String clientId;
  final String client;
  final String clientProfilePicture;
  final String clientNumber;
  final String recipientId;
  final String recipient;
  final String recipientProfilePicture;
  final String recipientNumber;
  final String serviceId;
  final String serviceTitle;
  final String serviceDescription;
  final String description;
  final bool viewed;
  final String price;
  final String permit;

  RequestClass({
    required this.clientId,
    required this.client,
    required this.clientProfilePicture,
    required this.clientNumber,
    required this.recipientId,
    required this.recipient,
    required this.recipientProfilePicture,
    required this.recipientNumber,
    required this.serviceId,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.description,
    required this.viewed,
    required this.price,
    required this.permit,
  });
}
