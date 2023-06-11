import 'package:flutter/material.dart';
import 'package:weather_app/screens/nice_screen.dart';
import 'package:weather_app/screens/forecast_screen.dart';

class CombinedPage extends StatefulWidget {
  const CombinedPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CombinedPageState createState() => _CombinedPageState();
}

class _CombinedPageState extends State<CombinedPage> {
  int _currentPageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: const [
          NiceScreen(),
          Forecast(),
        ],
      ),
    );
  }
}

