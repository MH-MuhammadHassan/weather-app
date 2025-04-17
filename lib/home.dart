import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/custom_cards/custom_icon_card.dart';
import 'package:weather_app/custom_cards/custom_sizedbox.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final apiUrl =
      'http://api.openweathermap.org/data/2.5/forecast?q=Karachi&APPID=fd8684ff9cecdbb4b1613b342a7afbb4';
  @override

// cod 200 = successfull
// cod 400 = failed
  // Function for weather
  Future getCurrentWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    final data = jsonDecode(
        response.body); // get the data from api and saved it in data varaiable
    return data;
    // check for 200 code
    // if (data['cod'] != '200') {
    //   throw 'unexpected error occured'; // funtion return if error occurs
    // } else {
    //   print(data['list'][0]['main']['temp']);
    // }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29292B),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff29292B),
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // stor variables
                final weatherSnapshot = snapshot.data['list'][0];
                final currentTemp = weatherSnapshot['main']['temp'];
                final humidity = weatherSnapshot['main']['humidity'];
                final windSpeed = weatherSnapshot['wind']['speed'];
                final pressure = weatherSnapshot['main']['pressure'];
                final weatherMain =
                    snapshot.data['list'][0]['weather'][0]['main'];
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: Card(
                            elevation: 10,
                            color: const Color(0xff3B3841),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "$currentTemp K",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    weatherMain == 'Clouds' ||
                                            weatherMain == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  Text(
                                    "$weatherMain",
                                    style: TextStyle(
                                        color: Color(0xffE4E1E8), fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Hourly Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              // convert dt_txt": "2025-02-05 12:00:00" into time: using INTL package
                              final time = DateTime.parse(
                                  snapshot.data['list'][index + 1]['dt_txt']);
                              return CustomSizedbox(
                                time: DateFormat.Hm().format(time),
                                icon: snapshot.data['list'][index + 1]
                                                ['weather'][0]['main'] ==
                                            'Clouds' ||
                                        snapshot.data['list'][index + 1]
                                                ['weather'][0]['main'] ==
                                            'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                temperature:
                                    "${snapshot.data['list'][index + 1]['main']['temp']}",
                              );
                            },
                            itemCount: 5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Additional Information",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconCard(
                                icon: Icons.water_drop,
                                text: "Humidity",
                                time: "$humidity"),
                            CustomIconCard(
                              icon: Icons.air,
                              text: "Wind Speed",
                              time: "$windSpeed",
                            ),
                            CustomIconCard(
                              icon: Icons.speed,
                              text: "Pressure",
                              time: "$pressure",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text("data not found");
              }
            } else {
              return const Center(
                  // CircularProgressIndicator.adaptive = (Loading circle changes based on operating system)
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
          }),
    );
  }
}
