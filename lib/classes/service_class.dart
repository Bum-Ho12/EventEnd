class Service {
  final int id;
  final String title;
  final String organizer;
  final int organizerId;
  final String organizerProfilePicture;
  final String long;
  final String lat;
  final String description;
  final String price;
  final String permit;
  final String webLink;
  final String socialMediaLink;
  final int traffic;

  Service({
    required this.id,
    required this.title,
    required this.organizer,
    required this.organizerId,
    required this.organizerProfilePicture,
    required this.long,
    required this.lat,
    required this.description,
    required this.price,
    required this.permit,
    required this.webLink,
    required this.socialMediaLink,
    required this.traffic,
  });
}

class ServiceCreate {
  final String title;
  final String description;
  final int price;
  final String webLink;

  ServiceCreate({
    required this.title,
    required this.description,
    required this.price,
    required this.webLink,
  });
}
