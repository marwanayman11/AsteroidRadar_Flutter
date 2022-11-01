import 'package:asteroid_radar/models/asteroid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailScreen extends StatelessWidget {
  final Asteroid? asteroid;

  const DetailScreen(this.asteroid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.grey.shade900),
        backgroundColor: Colors.grey.shade900,
        title: Text(asteroid!.codeName),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image(
                image: asteroid!.isPotentiallyHazardous
                    ? const AssetImage("assets/images/asteroid_hazardous.png")
                    : const AssetImage("assets/images/asteroid_safe.png")),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Close approach date",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              subtitle: Text(
                asteroid!.closeApproachDate,
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Absolute magnitude",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              subtitle: Text(
                "${asteroid!.absoluteMagnitude} au",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Estimated diameter",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              subtitle: Text(
                "${asteroid!.estimatedDiameter} km",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Relative velocity",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              subtitle: Text(
                "${asteroid!.relativeVelocity} km/s",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Distance from earth",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              subtitle: Text(
                "${asteroid!.distanceFromEarth} au",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
