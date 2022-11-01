class PictureOfTheDay {
  late String mediaType;
  late String title;
  late String url;

  PictureOfTheDay.fromJson(Map<String, dynamic> json) {
    mediaType = json['media_type'];
    title = json['title'];
    url = json['url'];
  }
}
