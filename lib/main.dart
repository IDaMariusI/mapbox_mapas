import 'package:flutter/material.dart';

import 'package:mapbox_mapas/src/views/fullscreenmap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapbox',
      home: Scaffold(
        body: FullScreenMap(),
      ),
    );
  }
}
//pk.eyJ1Ijoia2xlcn10aCIsImEiOiJja2N1b2NnOGExMGRvMnJsMXp5YjdrZjRnIn0.lDKL-dYT_LUEl6F6f4e78A