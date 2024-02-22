import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/key.dart';
import 'package:weather_app/widgets/additional_info.dart';
import 'package:weather_app/widgets/forecast_card.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<Map<String, dynamic>> getWeather() async {
    try {
      String cityName = 'Ghazipur,IN';
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$key'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') throw "OOPS!!!\n${data["message"]}";

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 5,
            ));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            );
          }

          final data = snapshot.data!;

          final currData = data['list'][1]['main'];
          final CurrTemp = currData['temp'] - 273.15;
          final weather = data['list'][1]['weather'][0]['main'];
          final pressure = currData['pressure'];
          final humidity = currData['humidity'];
          final windSpeed = data['list'][1]['wind']['speed'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 20),
                      elevation: 16,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaY: 10,
                            sigmaX: 10,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '${CurrTemp.toString().substring(0, 5)} °C',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                weather == 'Clear'
                                    ? Icons.wb_sunny_sharp
                                    : weather == 'Rain'
                                        ? Icons.beach_access_rounded
                                        : Icons.cloud,
                                size: 140,
                              ),
                              Text(
                                '$weather   ',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 3),
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      itemCount: 15,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final forecast = data['list'][index + 2];
                        final forecastSky = forecast['weather'][0]['main'];
                        final temp = forecast['main']['temp'] - 272.15;
                        final time = DateTime.parse(forecast['dt_txt']);
                        return card(
                          time: DateFormat('d MMM ').format(time) +
                              DateFormat.j().format(time),
                          temp: '${temp.toString().substring(0, 5)} °C',
                          weatherIcon: forecastSky == 'Clear'
                              ? Icons.wb_sunny_sharp
                              : forecastSky == 'Rain'
                                  ? Icons.beach_access_rounded
                                  : Icons.cloud,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Additional Infromation',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 3),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Info(
                          icon: Icons.water_drop_sharp,
                          title: 'Humidity',
                          value: '$humidity'),
                      Info(
                          icon: Icons.air_outlined,
                          title: 'Wind Speed',
                          value: '$windSpeed'),
                      Info(
                          icon: Icons.thermostat_rounded,
                          title: 'Pressure',
                          value: '$pressure'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
