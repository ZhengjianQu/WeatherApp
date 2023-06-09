import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.8),
          toolbarHeight: 50,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // TODO: TODO Samuel has que sirva para la navigation to the previous screen
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image.asset(
              'assets/Background/gotas-lluvia-ventana 1.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55), // Adjusted top padding
              child: Center(
                child: Container(
                  width: 305,
                  height: 685,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        width: 235,
                        height: 117,
                        decoration: BoxDecoration(
                          color: const Color(0x8048319D),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0x33FFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'email@example.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Samuel has que sirva
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color(0x48319D80),
                                fixedSize: const Size(73, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: Color(0x33FFFFFF),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Info',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 235,
                        height: 117,
                        decoration: BoxDecoration(
                          color: const Color(0x8048319D),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0x33FFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'email@example.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: TODO Samuel has que sirva
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color(0x48319D80),
                                fixedSize: const Size(73, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: Color(0x33FFFFFF),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Info',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 235,
                        height: 117,
                        decoration: BoxDecoration(
                          color: const Color(0x8048319D),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0x33FFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'email@example.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Samuel has que sirva
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color(0x48319D80),
                                fixedSize: const Size(73, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: Color(0x33FFFFFF),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Info',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 235,
                        height: 117,
                        decoration: BoxDecoration(
                          color: const Color(0x8048319D),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0x33FFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'email@example.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ElevatedButton(
                              onPressed: () {
                                // TODO Samuel has que sirva
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color(0x48319D80),
                                fixedSize: const Size(73, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: Color(0x33FFFFFF),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Info',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 57),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 110,
              top: 50 / 2, //
              child: Image.asset(
                'assets/Background/team.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
