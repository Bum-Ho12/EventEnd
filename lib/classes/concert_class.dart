class Concert {
  final int id;
  final String title;
  final String organizer;
  final int organizerId;
  final String organizeProfilePicture;
  final String concertPicture;
  final String eventDate;
  final String fromHour;
  final String toHour;
  final String location;
  final String long;
  final String lat;
  final String description;
  final String price;
  final String webLink;
  final int traffic;
  final int tickets;

  Concert({
    required this.id,
    required this.title,
    required this.organizer,
    required this.organizerId,
    required this.organizeProfilePicture,
    required this.concertPicture,
    required this.eventDate,
    required this.fromHour,
    required this.toHour,
    required this.location,
    required this.long,
    required this.lat,
    required this.description,
    required this.price,
    required this.webLink,
    required this.traffic,
    required this.tickets,
  });
}

class ConcertCreate {
  final String title;
  final String eventDate;
  final String fromHour;
  final String toHour;
  final String location;
  final String description;
  final int price;
  final String webLink;

  ConcertCreate({
    required this.title,
    required this.eventDate,
    required this.fromHour,
    required this.toHour,
    required this.location,
    required this.description,
    required this.price,
    required this.webLink,
  });
}
