class FavoriteService {
  final int id;
  final String title;
  final String organizer;
  final int organizerId;
  final String organizerProfilePicture;
  final int serviceId;
  final String organizerMediaLink;

  FavoriteService({
    required this.id,
    required this.title,
    required this.organizer,
    required this.organizerId,
    required this.organizerProfilePicture,
    required this.serviceId,
    required this.organizerMediaLink,
  });
}

class FavoriteConcert {
  final int id;
  final String title;
  final String organizer;
  final int organizerId;
  final String organizerProfilePicture;
  final int concertId;
  final String concertPicture;
  final String organizerMediaLink;

  FavoriteConcert({
    required this.id,
    required this.title,
    required this.organizer,
    required this.organizerId,
    required this.organizerProfilePicture,
    required this.concertId,
    required this.concertPicture,
    required this.organizerMediaLink,
  });
}
