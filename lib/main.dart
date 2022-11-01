import 'package:asteroid_radar/main/cubit/cubit.dart';
import 'package:asteroid_radar/main/cubit/states.dart';
import 'package:asteroid_radar/main/main_screen.dart';
import 'package:asteroid_radar/shared/network/local/bloc_observer.dart';
import 'package:asteroid_radar/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => MainCubit()
          ..getPictureData()
          ..getAsteroidsData(),
        child: BlocConsumer<MainCubit, MainStates>(
          builder: (context, state) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
            );
          },
          listener: (context, state) {},
        ));
  }
}
