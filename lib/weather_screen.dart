import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/addidtion_informationBox.dart';
import 'package:weather_app/weather_box.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();

    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    String cityName = "London";

    try {
      final res = await http.get(
        Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&id=524901&appid=c15430f4119d8e6f48a8d8af85ce2a9c",
        ),
      );

      if (res.statusCode != 200) {
        throw "Some error occured";
      }

      final data = jsonDecode(res.body);

      return data;
      //_temp = (data['list'][0]["main"]["temp"]);
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Text("${snapshot.error.toString()}");
          }

          final data = snapshot.data!;

          final currentTemp = data['list'][0]["main"]["temp"];
          final currentSky = data['list'][0]["weather"][0]["main"];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text(
                          currentTemp.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            currentSky == "Clouds" || currentSky == "Rain"
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 70,
                          ),
                        ),
                        Text(
                          currentSky,
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Weather Forcast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 4; i++)
                //         WeatherForcast(temp: "${i * 50 + 25} F"),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return WeatherForcast(temp: "${index * 50 + 25} F");
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AddidtioniInformationBox(
                        icon: Icons.water_drop, title: "Test", degree: 90),
                    AddidtioniInformationBox(
                        icon: Icons.wind_power, title: "Weather", degree: 15),
                    AddidtioniInformationBox(
                        icon: Icons.umbrella_sharp, title: "Cloud", degree: 60)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
