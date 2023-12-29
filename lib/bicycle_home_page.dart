import 'package:cycle/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cycle/bicycle_user_profile.dart';   

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyMapPage(), // Launch the map directly from the app's entry point
    );
  }
}

class MyMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenStreetMap'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09), // Set the initial map center (latitude, longitude)
          zoom: 13.0, // Set the initial zoom level
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'], // OSM tile subdomains
          ),
        ],
      ),
    );
  }
}

class BicycleRentalHomePage extends StatefulWidget {
  @override
  _BicycleRentalHomePageState createState() => _BicycleRentalHomePageState();
}

class _BicycleRentalHomePageState extends State<BicycleRentalHomePage> {
  int bottomIndex = 0;

  void handleLogout() async {
    // Sign out the user using Firebase Authentication
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyLogin()), // Replace 'LoginPage' with your actual login page
      );
    } catch (e) {
      // Handle any potential sign-out errors
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("Hello, ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Rider", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Spacer(),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    SizedBox(width: 16), // Add some spacing
                    IconButton(
                      onPressed: handleLogout,
                      icon: Icon(Icons.exit_to_app), // Replace with the out-of-gate symbol icon
                      iconSize: 36, // Adjust the size as needed
                      color: Colors.orange, // Set the color you prefer
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 72,
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: GNav(
            selectedIndex: bottomIndex,
            onTabChange: (idx) {
              setState(() {
                bottomIndex = idx;
              });
            },
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 250),
            gap: 2,
            activeColor: Colors.black,
            iconSize: 24,
            tabBackgroundColor: Colors.orange,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.bicycle,
                text: 'Bikes',
              ),
              GButton(
                icon: LineIcons.voicemail,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
