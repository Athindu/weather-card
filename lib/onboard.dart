import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_data/app_styles.dart';
import 'package:weather_data/home_page.dart';
import 'package:weather_data/utils/forecast.dart';
import 'package:weather_data/utils/location.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


  late LocationHelper locationData;
  late WeatherData weatherData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      // todo: Handle no location
      locationData.latitude = 6.011049;
      locationData.longitude = 80.5027014;
    }

    print(locationData.longitude);
    print(locationData.latitude);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetCheck();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 350,),
            Container(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused))
                          return Colors.red;
                        return null; // Defer to the widget's default.
                      }
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(weatherData: weatherData,),
                      ));
                },
                child: Text('TextButton'),
              ),
            ),
          ],
        ),
    );
  }

  void internetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      print('Internet available');
      getWeatherData();
    }
    else {
      print('No internet :( Reason:');
      await getLocationData();
      weatherData = WeatherData(locationData: locationData);
      weatherData.getNormalWeather();

      print(weatherData.currentTemperature);
      print(weatherData.currentCondition);
      print(weatherData.city);
      print(weatherData.feels_like);
      print(weatherData.temp_min);

    }
  }


  void getWeatherData() async {
    // Fetch the location

    await getLocationData();
    // Fetch the current weather
    weatherData = WeatherData(locationData: locationData);
    //print(weatherData.currentTemperature);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null || weatherData.city == null ||
        weatherData.feels_like ==null || weatherData.temp_min ==null  ) {
      // todo: Handle no weather
    }

    print(weatherData.currentTemperature);
    print(weatherData.currentCondition);
    print(weatherData.city);
    print(weatherData.feels_like);
    print(weatherData.temp_min);

  }



}
