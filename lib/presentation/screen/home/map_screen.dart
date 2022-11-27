import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String sitename;

  const MapScreen(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.sitename})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void directToMap() {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${double.parse(widget.latitude)},${double.parse(widget.longitude)}";

    try {
      canLaunchUrl(Uri.parse(googleMapslocationUrl))
          .then((value) {
        if (value) {
          launchUrl(Uri.parse(googleMapslocationUrl));
        } else {
          throw 'Could not launch';
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: _createMarker(),
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.latitude),
                    double.parse(widget.longitude)),
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController controller) {},
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                directToMap();
              },
              child: Text(
                "BUKA GOOGLE MAPS",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId(widget.sitename),
        position: LatLng(
            double.parse(widget.latitude), double.parse(widget.longitude)),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: widget.sitename),
      ),
    ].toSet();
  }
}
