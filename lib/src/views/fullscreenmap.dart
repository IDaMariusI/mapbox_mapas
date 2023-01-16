import 'package:flutter/material.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  String selectedStyle = MapboxStyles.LIGHT;
  String lightStyle = MapboxStyles.LIGHT;
  String darkStyle = MapboxStyles.DARK;

  final center = const LatLng(37.810575, -122.477174);

  MapboxMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createMap(),
      floatingActionButton: floatingButtons(),
    );
  }

  Column floatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //Zoom In
        FloatingActionButton(
          child: const Icon(Icons.zoom_in_outlined),
          onPressed: () {
            mapController?.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        const SizedBox(height: 5),
        //Zoom Out
        FloatingActionButton(
          child: const Icon(Icons.zoom_out_outlined),
            onPressed: (){
              mapController?.animateCamera(CameraUpdate.zoomOut());
            },
        ),
        const SizedBox(height: 5),
        //Change App Style
        FloatingActionButton(
          child: const Icon(Icons.add_to_home_screen_outlined),
          onPressed: () {
            if (selectedStyle == lightStyle) {
              selectedStyle = darkStyle;
            } else {
              selectedStyle = lightStyle;
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  MapboxMap createMap() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoadedCallback,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 14,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }
}
