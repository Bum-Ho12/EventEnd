class Account {
  final String name;
  final String token;
  final String email;
  final String password;
  final String location;
  final String profilePicture;
  final int weekdayFrom;
  final int weekdayTo;
  final String fromHour;
  final String toHour;
  final String socialMediaLink;
  final String description;
  final String phoneNumber;
  final double long;
  final double lat;
  final int category;

  Account({
    this.name = '',
    this.token = '',
    this.email = '',
    this.password = '',
    this.category = 1,
    this.location = '',
    this.profilePicture = '',
    this.weekdayFrom = 1,
    this.weekdayTo = 5,
    this.fromHour = '',
    this.toHour = '',
    this.socialMediaLink = '',
    this.description = '',
    this.phoneNumber = '',
    this.long = 0.0000,
    this.lat = 0.0000,
  });
}
