//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
//import 'package:weather_app/views/additional_information.dart';
import 'package:weather_app/views/current_weather.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather_app/widgets/navigation_drawer_widget.dart';


var background = "clear";
var location = "Berlin";
var units = "metric";
var unitSymbol = "°C";
var speedUnits = "m/s";
var selectedUnitIndex = 0;

class NiceScreen extends StatefulWidget{
  const NiceScreen({Key? key}) : super(key: key);
  @override
  State<NiceScreen> createState() => _NiceScreenState();
}

class _NiceScreenState extends State<NiceScreen> {

  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  //the controller keeps track of what the user is typing
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;





  //CustomSearchDelegate searchDelegate = CustomSearchDelegate();

  Future<void> getData() async{
    data = await client.getCurrentWeather(location, units);
  }

  void _onTextChanged(String value) {
    setState(() {
      _showClearButton = value.isNotEmpty;
    });
  }

  void _onClear() {
    setState(() {
      _searchController.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFf9f9f9),
        //this is the sidebar menu
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
            backgroundColor: const Color(0xE6000000),
            elevation: 0.0,
            title: Stack(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onTextChanged,
                  style : const TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          location = "current";
                          _onClear();
                        });
                      },
                      icon: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.deepPurple,
                      ),
                    ),
                    fillColor: const Color(0xE2ffffff),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search City...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: _showClearButton ? null : const Icon(Icons.search),
                    suffixIconColor: Colors.grey,
                  ),
                  onSubmitted: (String value){
                    setState(() {
                      location = _searchController.text;
                      _onClear();
                    });
                  },
                ),
                Visibility(
                  visible: _showClearButton,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: _onClear,
                          icon: const Icon(Icons.clear)
                      )
                    ]
                  ),
                ),
              ],
            ),
            centerTitle: true,
            //leading: IconButton(
            //  onPressed: () {},
            //  icon: const Icon(Icons.menu),
            //  color: Colors.deepPurple,
            //),
            actions: <Widget>[
              ToggleSwitch(
                initialLabelIndex: selectedUnitIndex,
                totalSwitches: 2,
                labels: const ['°C', '°F'],
                onToggle: (index) {
                  setState(() {
                    selectedUnitIndex = index!;
                    if (index == 0) {
                      units = "metric";
                      unitSymbol = "°C";
                    }
                    else {
                      units = "imperial";
                      unitSymbol = "°F";
                      speedUnits = "m/h";
                    }
                  });
                  getData();
                  background = data!.mainDescription!;
                },
              )
            ]
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/Background/$background.png',
              ),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(30, 120, 30, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        return Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            currentWeather("${data!.skyIcon}", "${data!.temp!.round()}$unitSymbol", "${data!.cityName}", "${data!.mainDescription}"),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),

                  const SizedBox(height: 8),
                  Container(
                      margin : const EdgeInsets. symmetric( vertical: 10, horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(72, 49, 157, 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    const Text(
                                      "Feels like",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white60,
                                      )
                                    ),
                                    Text(
                                      //"${data!.realFeel!.toInt().toString()}°",
                                      (data!.realFeel!.toInt().toString() + unitSymbol),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Similarity rate.",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white60
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(72, 49, 157, 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Humidity",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white60
                                      ),
                                    ),
                                    Text(
                                      "${data!.humidity}%",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'The dew point is ${(data!.temp! - ((100 - data!.humidity!.toInt()) / 5)).round()} right now.',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white60),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(72, 49, 157, 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Visibility',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white60,
                                    ),
                                  ),
                                  Text(
                                    "${(data!.visibility!/ 1000).round()}Km",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                      ),
                                  ),
                                  const Text(
                                    'Max 10km.',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white60
                                  ),
                                  )
                                ],
                              ),
                            )
                          ),
                        ),

                        const SizedBox(width: 20),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(0x48, 0x31, 0x9D, 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Wind',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white60,
                                    ),
                                  ),
                                  Text(
                                    data!.windSpeed.toString(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text(
                                    speedUnits,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white60
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),


                ]
              ),
            )
          ),
        ),
      ),

        //body: Stack(
        //  children: [
        //    Image.asset(
        //        'assets/Background/rain.png',
        //      fit: BoxFit.cover,
        //      height: double.infinity,
        //      width: double.infinity,
        //    ),
        //    Padding(
        //        padding: const EdgeInsets.only(top: 50),
        //      child: Center(
        //        child: Container(
        //          width: 350,
        //          height: 715,
        //          decoration: BoxDecoration(
        //            color: Colors.black.withOpacity(0.8),
        //            borderRadius: BorderRadius.circular(20),
        //          ),
//
        //          child: FutureBuilder(
        //            future: getData(),
        //            builder: (context, snapshot){
        //              if(snapshot.connectionState == ConnectionState.done){
        //                return Column(crossAxisAlignment: CrossAxisAlignment.center,
        //                  mainAxisAlignment: MainAxisAlignment.start,
        //                  children: [
        //                    currentWeather("${data!.skyIcon}", "${data!.temp!.round()} °$unitSymbol", "${data!.cityName}"),
        //                  ],
        //                );
        //              }
        //              return Container();
        //            },
        //          ),
        //        ),
        //      ),
        //    ),
//
        //    //TODO: write all the code below into the additional_informatiton.dart file
//
        //    Padding(
        //      padding: const EdgeInsets.only(top: 450, left: 45),
        //      child: Container(
        //        //child: Text,
        //        width: 140,
        //        height: 130,
        //        decoration: BoxDecoration(
        //          color: Colors.deepPurple.withOpacity(0.2),
        //          borderRadius: BorderRadius.circular(20),
        //          border: Border.all(color: Colors.grey),
        //        )
        //      ),
//
        //    //  child: GridView.count(
        //    //    crossAxisCount: 2,
        //    //    children: List.generate(4, (index) {
        //    //      return Center(
        //    //        child: Text(
        //    //          'Item $index',
        //    //          style: TextStyle(
        //    //              color: Colors.white
        //    //          ),
        //    //        ),
        //    //      );
        //    //    }),
        //    //  ),
        //    ),
//
        //    Padding(
        //      padding: const EdgeInsets.only(top: 450, left: 220),
        //      child: Container(
        //          //child: Text,
        //          width: 140,
        //          height: 130,
        //          decoration: BoxDecoration(
        //            color: Colors.deepPurple.withOpacity(0.2),
        //            borderRadius: BorderRadius.circular(20),
        //            border: Border.all(color: Colors.grey),
        //          )
        //      ),
        //    ),
//
        //    Padding(
        //      padding: const EdgeInsets.only(top: 650, left: 220),
        //      child: Container(
        //        //child: Text,
        //          width: 140,
        //          height: 130,
        //          decoration: BoxDecoration(
        //            color: Colors.deepPurple.withOpacity(0.2),
        //            borderRadius: BorderRadius.circular(20),
        //            border: Border.all(color: Colors.grey),
        //          )
        //      ),
        //    ),
//
        //    Padding(
        //      padding: const EdgeInsets.only(top: 650, left: 45),
        //      child: Container(
        //        //child: Text,
        //          width: 140,
        //          height: 130,
        //          decoration: BoxDecoration(
        //            color: Colors.deepPurple.withOpacity(0.2),
        //            borderRadius: BorderRadius.circular(20),
        //            border: Border.all(color: Colors.grey),
        //          )
        //      ),
        //    ),
//
        //  ],
        //),
      //),
    );
  }
  
}