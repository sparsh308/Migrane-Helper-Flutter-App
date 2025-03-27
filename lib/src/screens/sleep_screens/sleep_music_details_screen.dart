import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:migrane_helper/src/common_widgets/app_buttons.dart';
import 'package:migrane_helper/src/common_widgets/app_images.dart';
import 'package:migrane_helper/src/common_widgets/app_text.dart';
import 'package:migrane_helper/src/screens/sleep_screens/sleep_music_card_widget/sleep_music_card_widget.dart';
import 'package:migrane_helper/src/themes/theme.dart';

class SleepMusicDetailsScreen extends StatefulWidget {
  final SleepMusicCardData music;

  const SleepMusicDetailsScreen({Key? key, required this.music}) : super(key: key);

  @override
  _SleepMusicDetailsScreenState createState() => _SleepMusicDetailsScreenState();
}

class _SleepMusicDetailsScreenState extends State<SleepMusicDetailsScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await _audioPlayer.setAsset(widget.music.audioPath);

    // Listen for duration changes
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _duration = duration;
        });
      }
    });

    // Listen for position changes
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    // Listen for playback state changes to sync play/pause button
    _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        isPlaying = playerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayback() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void _seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff03174C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: "${widget.music.id}+image",
                child: AppImages.roundedContainerWithImage(
                  widget.music.imagePath,
                  height: 250,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    AppText.normalText(
                      widget.music.title,
                      fontSize: 34,
                      isBold: true,
                      color: AppTheme.of(context).theme.sleepMusicCardTextHeaderColor,
                    ),
                    const SizedBox(height: 15),
                    AppText.normalText(
                      widget.music.duration,
                      fontSize: 14,
                      isBold: true,
                      color: AppTheme.of(context).theme.sleepMusicCardTextBodyColor,
                    ),
                    const SizedBox(height: 20),
                    AppText.normalText(
                      widget.music.desc,
                      fontSize: 16,
                      color: AppTheme.of(context).theme.sleepMusicCardTextBodyColor,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 1, color: Colors.white),
                    const SizedBox(height: 20),

                    // Music progress bar
                    Column(
                      children: [
                        Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey.shade600,
                          min: 0,
                          max: _duration.inSeconds.toDouble(),
                          value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble()),
                          onChanged: (value) {
                            _seekTo(Duration(seconds: value.toInt()));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(_position),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              _formatDuration(_duration),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Play/Pause Button
                    Center(
                      child: IconButton(
                        iconSize: 80,
                        icon: Icon(
                          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: _togglePlayback,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
