import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff2196f3),
        canvasColor: const Color(0xfffafafa),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static ui.Image? _img = null;
  static bool _flg = false;

  Future<void> loadAssetImage(String fname) async {
    final bd = await rootBundle.load("assets/images/$fname");
    final Uint8List u8lst = await Uint8List.view(bd.buffer);
    final codec = await ui.instantiateImageCodec(u8lst);
    final frameInfo = await codec.getNextFrame();
    _img = frameInfo.image;
    setState(() {
      _flg = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadAssetImage('image.jpg');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'App Name',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      body: Container(
        child: CustomPaint(
          painter: MyPainter(_img),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  ui.Image? _img = null;

  MyPainter(this._img);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();

    Offset off = Offset(50.0, 50.0);
    if (_img != null) {
      canvas.drawImage(_img!, off, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
