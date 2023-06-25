import 'package:all_events_task/data/responses/event_details_response.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation extends StatefulWidget {
  final EventDetailsResponse event;
  const GetLocation({Key? key, required this.event}) : super(key: key);

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {

  double? lat;

  double? long;

  String address = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }



  getLatLong() {

      setState(() {
        lat = widget.event.venue?.longitude?.floorToDouble();
        long = widget.event.venue?.longitude?.floorToDouble();
      });

  }




@override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
       color: Colors.lightBlue,
       child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: getLatLong,
              child: const Text("Get Location"),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF0D39F2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
