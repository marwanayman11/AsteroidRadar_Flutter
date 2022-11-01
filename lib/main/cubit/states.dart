abstract class MainStates {}

class InitialState extends MainStates {}

class GetAsteroidsLoadingState extends MainStates {}

class GetAsteroidsSuccessState extends MainStates {}

class GetAsteroidsErrorState extends MainStates {
  late final String error;

  GetAsteroidsErrorState(this.error);
}

class GetAsteroidsTodayLoadingState extends MainStates {}

class GetAsteroidsTodaySuccessState extends MainStates {}

class GetAsteroidsTodayErrorState extends MainStates {
  late final String error;

  GetAsteroidsTodayErrorState(this.error);
}

class GetAsteroidsWeekLoadingState extends MainStates {}

class GetAsteroidsWeekSuccessState extends MainStates {}

class GetAsteroidsWeekErrorState extends MainStates {
  late final String error;

  GetAsteroidsWeekErrorState(this.error);
}

class GetPictureLoadingState extends MainStates {}

class GetPictureSuccessState extends MainStates {}

class GetPictureErrorState extends MainStates {
  late final String error;

  GetPictureErrorState(this.error);
}
