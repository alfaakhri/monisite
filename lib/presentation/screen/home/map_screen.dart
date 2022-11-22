import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                // final availableMaps = await MapLauncher.installedMaps;

                // await availableMaps.first.showMarker(
                //     coords:
                //         Coords(double.parse(latitude), double.parse(longitude)),
                //     title: widget.sitename);

                // Navigator.pop(context);
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
        position: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: widget.sitename),
      ),
    ].toSet();
  }
}
