// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strawhat Pirates Wanted Posters',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  final List<String> images = [
    'assets/Luffy.jpg',
    'assets/zoro.jpg',
    'assets/sanji.jpg',
    'assets/jimbei.jpg',
    'assets/ussop.jpg',
    'assets/franky.jpg',
    'assets/robin.jpg',
    'assets/brook.jpg',
    'assets/chopper.jpg',
    'assets/nami.jpg',
  ];

  final List<String> names = [
    'Monkey D. Luffy',
    'Roronoa Zoro',
    'Sanji',
    'Jimbei',
    'Usopp',
    'Franky',
    'Nico Robin',
    'Brook',
    'Tony Tony Chopper',
    'Nami',
  ];

  final List<String> sounds = [
    'luffy.mp3',
    'zoro.mp3',
    'sanji.mp3',
    'jinbei.mp3',
    'usopp.mp3',
    'frankky.mp3',
    'robin.mp3',
    'brook.mp3',
    'chopper.mp3',
    'nami.mp3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Strawhat Pirates Wanted Posters', style: TextStyle(
          color: Colors.black87
        ),),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => FullScreenImageScreen(
                  imagePath: images[index],
                  name: names[index],
                  soundPath: sounds[index],
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black54,
                elevation: 10,
                child: Image.asset(
                  images[index],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImageScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final String soundPath;

  FullScreenImageScreen({
    required this.imagePath,
    required this.name,
    required this.soundPath,
  });

  @override
  _FullScreenImageScreenState createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playSound();
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource(widget.soundPath));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black54,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(widget.imagePath),
            SizedBox(height: 2),
            Text(
              widget.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text('Close', style: TextStyle(
              fontSize: 24,
              color: Colors.red,
              
            ),),
          ),
        ),
      ],
    );
  }
}