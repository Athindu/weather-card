import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_data/app_styles.dart';
import 'package:weather_data/utils/forecast.dart';
import "string_extension.dart";


class HomeView extends StatefulWidget {

  final WeatherData weatherData;

  const HomeView({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late int temperature;
  late String city;
  late double temp_min;
  late double feels_like;
  late String currentCondition;
  late double temp_max;

  void updateDisplayInfo(WeatherData weatherData) {

    setState(() {
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      temp_min = weatherData.temp_min;
      temp_max = temp_min + 1.5;
      feels_like= weatherData.feels_like;
      currentCondition = weatherData.currentCondition.capitalize();
    });
  }



  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height:150),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: w,
            height: h * 0.25,
            decoration: BoxDecoration(
              //color: createMaterialColor(Color(0xFF329760)),
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  colors: [gradColor1, gradColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: Offset(-10, 10),
                    blurRadius: 15,
                    spreadRadius: 10)
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //Icon
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/cloudy.png',
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      //Image.asset('assets/icons/02d.png', width: 70, height:70),
                      Container(
                        margin: const EdgeInsets.only(left: 30, top: 10),
                        //margin: const EdgeInsets.all(5),
                        child: Text(
                            '$currentCondition',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white,
                            )),),

                      Container(
                        margin: const EdgeInsets.only(left: 32, top: 5),
                        child: Text(
                            'H: $temp_max°C  |  L: $temp_min°C',
                            textAlign:TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.white,
                            )),),
                    ],
                  ),
                ),

                Column(
                  children: [
                    SizedBox(height:20),
                    Container(
                      margin: const EdgeInsets.only(right: 12, top: 5),
                      child: Text(
                          ' $temperature°',
                          textAlign:TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.white,
                          )),),

                    Container(
                      margin: const EdgeInsets.only(right: 30, top: 5),
                      child: Text(
                          'Feels like $feels_like°C',
                          textAlign:TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.white,
                          )),),
                    SizedBox(height:30),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                          '$city',
                          textAlign:TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.white,
                          )),),

                  ],
                ),

              ],
            ),

          ),
        ],
      ),
    );
  }


}
