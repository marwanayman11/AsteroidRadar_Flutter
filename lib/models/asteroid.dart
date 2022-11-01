import 'package:date_format/date_format.dart';

class Objects {
  List<Asteroid> asteroids = [];

  Objects.fromJson(Map<String, dynamic> json) {
    getNextSevenDaysFormattedDates().forEach((element) {
      if (json[element] != null) {
        json[element].forEach((asteroid) {
          asteroids.add(Asteroid.fromJson(asteroid));
        });
      }
    });
  }
}

class Asteroid {
  late String id;

  late String codeName;
  late String closeApproachDate;
  late double absoluteMagnitude;
  late double estimatedDiameter;
  late String relativeVelocity;
  late String distanceFromEarth;
  late bool isPotentiallyHazardous;

  Asteroid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeName = json['name'];
    closeApproachDate = json['close_approach_data'][0]['close_approach_date'];
    absoluteMagnitude = json['absolute_magnitude_h'];
    estimatedDiameter =
        json['estimated_diameter']['kilometers']['estimated_diameter_max'];
    relativeVelocity = json['close_approach_data'][0]['relative_velocity']
        ['kilometers_per_second'];
    distanceFromEarth =
        json['close_approach_data'][0]['miss_distance']['astronomical'];
    isPotentiallyHazardous = json['is_potentially_hazardous_asteroid'];
  }
}

List<String> getNextSevenDaysFormattedDates() {
  List<String> formattedDateList = [];
  var currentTime = DateTime.now();
  for (int i = 1; i <= 7; i++) {
    String dateFormat = formatDate(currentTime, [yyyy, '-', mm, '-', dd]);
    formattedDateList.add(dateFormat);
    currentTime =
        DateTime(currentTime.year, currentTime.month, currentTime.day + 1);
  }
  return formattedDateList;
}
