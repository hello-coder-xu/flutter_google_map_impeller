import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    final mapRenderer = await mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest);
    debugPrint("Using Google Map renderer: $mapRenderer");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(25.0329694, 121.5654177),
                  zoom: 14.5,
                ),
                onCameraMove: (CameraPosition position) {
                  debugPrint("move : $position");
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
