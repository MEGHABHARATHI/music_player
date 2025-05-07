import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

void main() => runApp(MaSoApp());

class MaSoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaSo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.dark().copyWith(primary: Colors.deepPurple),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatefulWidget {
  @override
  _MusicHomePageState createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final player = AudioPlayer();
  String? currentSong;
  String? currentImage;
  bool isPlaying = false;

  final List<Map<String, String>> songs = [
    {
      'title': 'Kannadi Poove',
      'file': 'assets/music/kannadi Poovey.mp3',
      'image': 'assets/images/Kannadi_Poovey.jpg',
    },
    {
      'title': 'VENAM Machan',
      'file': 'assets/music/Venaam-Machan.mp3',
      'image': 'assets/images/Vena_Machan.jpg',
    },
    {
      'title': 'Nee Kavidhaigala',
      'file': 'assets/music/Nee-Kavithaigala.mp3',
      'image': 'assets/images/Nee_Kavidhaigala.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
  }

  Future<void> _playSong(String filePath, String title, String imagePath) async {
    try {
      await player.setAsset(filePath);
      await player.play();
      setState(() {
        currentSong = title;
        currentImage = imagePath;
        isPlaying = true;
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void _pause() {
    player.pause();
    setState(() => isPlaying = false);
  }

  void _resume() {
    player.play();
    setState(() => isPlaying = true);
  }

  void _stop() {
    player.stop();
    setState(() {
      isPlaying = false;
      currentSong = null;
      currentImage = null;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rainy Vibes 🎧'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Album Art
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                currentImage ?? 'assets/images/default_music_image.png',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Song Title
            Text(
              currentSong ?? "Choose your vibe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.stop, color: Colors.redAccent),
                  onPressed: _stop,
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.deepPurpleAccent,
                    size: 50,
                  ),
                  onPressed: isPlaying ? _pause : _resume,
                ),
              ],
            ),
            SizedBox(height: 20),

            Divider(color: Colors.deepPurpleAccent),

            // Playlist
            Expanded(
              child: ListView(
                children: songs.map((song) {
                  return ListTile(
                    leading: Icon(Icons.music_note, color: Colors.purpleAccent),
                    title: Text(song['title']!, style: TextStyle(color: Colors.white)),
                    onTap: () => _playSong(song['file']!, song['title']!, song['image']!),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
