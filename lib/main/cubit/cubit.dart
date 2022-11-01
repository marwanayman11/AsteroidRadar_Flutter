import 'package:asteroid_radar/main/cubit/states.dart';
import 'package:asteroid_radar/models/picture.dart';
import 'package:asteroid_radar/shared/network/remote/constants.dart';
import 'package:asteroid_radar/shared/network/remote/dio_helper.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/asteroid.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitialState());

  static MainCubit get(context) => BlocProvider.of(context);
  Objects? objects;
  List<Asteroid> asteroids = [];

  void getAsteroidsData() {
    emit(GetAsteroidsLoadingState());
    DioHelper.getData(url: getAsteroids, query: {
      'api_key': apiKey,
    }).then((value) {
      objects = Objects.fromJson(value.data["near_earth_objects"]);
      asteroids = objects!.asteroids;
      emit(GetAsteroidsSuccessState());
    }).catchError((error) {
      emit(GetAsteroidsErrorState(error.toString()));
    });
  }

  void getAsteroidsDataToday() {
    var currentTime = DateTime.now();
    String dateFormat = formatDate(currentTime, [yyyy, '-', mm, '-', dd]);
    emit(GetAsteroidsTodayLoadingState());
    DioHelper.getData(url: getAsteroids, query: {
      'start_date': dateFormat,
      'end_date': dateFormat,
      'api_key': apiKey,
    }).then((value) {
      objects = Objects.fromJson(value.data["near_earth_objects"]);
      asteroids = objects!.asteroids;
      emit(GetAsteroidsTodaySuccessState());
    }).catchError((error) {
      emit(GetAsteroidsTodayErrorState(error.toString()));
    });
  }

  void getAsteroidsDataWeek() {
    var currentTime = DateTime.now();
    var newTime =
        DateTime(currentTime.year, currentTime.month, currentTime.day + 1);
    String dateFormat = formatDate(newTime, [yyyy, '-', mm, '-', dd]);
    emit(GetAsteroidsWeekLoadingState());
    DioHelper.getData(url: getAsteroids, query: {
      'start_date': dateFormat,
      'api_key': apiKey,
    }).then((value) {
      objects = Objects.fromJson(value.data["near_earth_objects"]);
      asteroids = objects!.asteroids;
      emit(GetAsteroidsWeekSuccessState());
    }).catchError((error) {
      emit(GetAsteroidsWeekErrorState(error.toString()));
    });
  }

  PictureOfTheDay? pictureOfTheDay;

  void getPictureData() {
    emit(GetPictureLoadingState());
    DioHelper.getData(url: getPicture, query: {'api_key': apiKey})
        .then((value) {
      pictureOfTheDay = PictureOfTheDay.fromJson(value.data);
      emit(GetPictureSuccessState());
    }).catchError((error) {
      emit(GetAsteroidsErrorState(error.toString()));
    });
  }
}
