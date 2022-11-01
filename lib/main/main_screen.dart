import 'package:asteroid_radar/detail/detail_screen.dart';
import 'package:asteroid_radar/main/cubit/cubit.dart';
import 'package:asteroid_radar/main/cubit/states.dart';
import 'package:asteroid_radar/main/web_view.dart';
import 'package:asteroid_radar/models/asteroid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_preview/cached_video_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
        builder: (context, state) {
          var cubit = MainCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(
              actions: [
                PopupMenuButton(
                    color: Colors.black,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text(
                              "Today",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              cubit.getAsteroidsDataToday();
                            },
                          ),
                          PopupMenuItem(
                            child: const Text("Week",
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              cubit.getAsteroidsDataWeek();
                            },
                          ),
                          PopupMenuItem(
                            child: const Text("All",
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              cubit.getAsteroidsData();
                            },
                          ),
                        ])
              ],
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.grey.shade900),
              backgroundColor: Colors.grey.shade900,
              title: const Text("Asteroid Radar"),
            ),
            body: cubit.asteroids.isNotEmpty && cubit.pictureOfTheDay != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            cubit.pictureOfTheDay!.mediaType == "video"
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewScreen(cubit
                                                      .pictureOfTheDay!.url)));
                                    },
                                    child: CachedVideoPreviewWidget(
                                      path: cubit.pictureOfTheDay!.url,
                                      type: SourceType.remote,
                                      remoteImageBuilder: (context, url) =>
                                          CachedNetworkImage(
                                        imageUrl: url,
                                        placeholder: (context, url) => const Image(
                                            image: AssetImage(
                                                "assets/images/placeholder.jpg")),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewScreen(cubit
                                                      .pictureOfTheDay!.url)));
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: cubit.pictureOfTheDay!.url,
                                      placeholder: (context, url) => const Image(
                                          image: AssetImage(
                                              "assets/images/placeholder.jpg")),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                            Container(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(cubit.pictureOfTheDay!.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            )
                          ],
                        ),
                        state is GetAsteroidsLoadingState ||
                                state is GetAsteroidsTodayLoadingState ||
                                state is GetAsteroidsWeekLoadingState
                            ? const Center(child: LinearProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10.0),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        asteroidItem(
                                            context, cubit.asteroids[index]),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 5,
                                        ),
                                    itemCount: cubit.asteroids.length),
                              )
                      ],
                    ),
                  )
                : const LinearProgressIndicator(),
          );
        },
        listener: (context, state) {});
  }
}

Widget asteroidItem(BuildContext context, Asteroid asteroid) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailScreen(asteroid)));
    },
    child: Card(
        color: Colors.black,
        child: ListTile(
          title: Text(
            asteroid.codeName,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(asteroid.closeApproachDate,
              style: const TextStyle(color: Colors.grey)),
          trailing: asteroid.isPotentiallyHazardous
              ? const Icon(
                  Icons.dangerous_outlined,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.blue,
                ),
        )),
  );
}
