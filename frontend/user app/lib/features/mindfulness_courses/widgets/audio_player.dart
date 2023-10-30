// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/course_level.dart';

class AudioPlayera extends StatefulWidget {
  final String musicUrl;
  final String imageUrl;
  final MindfulnessCourseLevel level;
  const AudioPlayera({
    Key? key,
    required this.musicUrl,
    required this.imageUrl,
    required this.level,
  }) : super(key: key);

  @override
  State<AudioPlayera> createState() => _AudioPlayeraState();
}

class _AudioPlayeraState extends State<AudioPlayera> {
  late String musicUrl; // Insert your music URL
  late String thumbnailImgUrl;
// Insert your thumbnail URL
  bool loaded = false;
  bool playing = false;
  late AudioPlayer player;

  void initState() {
    player = AudioPlayer();
    musicUrl = widget.musicUrl;
    thumbnailImgUrl = widget.imageUrl;
    loadMusic();
    super.initState();
  }

  void loadMusic() async {
    try {
      print(musicUrl);
      await player.setUrl(musicUrl);
      setState(() {
        print("loadded");
        loaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: WaveBackground(),
          alignment: Alignment.bottomCenter,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // image: DecorationImage(
            // image: NetworkImage(
            //     '$uri/api/assets/image/mind-course/${featuredCourse[index].image}'),
          ),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: StreamBuilder(
                    stream: player.positionStream,
                    builder: (context, snapshot1) {
                      final Duration duration = loaded
                          ? snapshot1.data as Duration
                          : const Duration(seconds: 0);
                      return StreamBuilder(
                          stream: player.bufferedPositionStream,
                          builder: (context, snapshot2) {
                            final Duration bufferedDuration = loaded
                                ? snapshot2.data as Duration
                                : const Duration(seconds: 0);
                            return SizedBox(
                              height: 30,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ProgressBar(
                                  progress: duration,
                                  total: player.duration ??
                                      const Duration(seconds: 0),
                                  buffered: bufferedDuration,
                                  timeLabelPadding: -1,
                                  timeLabelTextStyle: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  progressBarColor: Colors.red,
                                  baseBarColor: Colors.grey[200],
                                  bufferedBarColor: Colors.grey[350],
                                  thumbColor: Colors.red,
                                  onSeek: loaded
                                      ? (duration) async {
                                          await player.seek(duration);
                                        }
                                      : null,
                                ),
                              ),
                            );
                          });
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: loaded
                          ? () async {
                              if (player.position.inSeconds >= 10) {
                                await player.seek(Duration(
                                    seconds: player.position.inSeconds - 10));
                              } else {
                                await player.seek(const Duration(seconds: 0));
                              }
                            }
                          : null,
                      icon: const Icon(Icons.fast_rewind_rounded)),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: IconButton(
                        onPressed: loaded
                            ? () {
                                if (playing) {
                                  pauseMusic();
                                } else {
                                  playMusic();
                                }
                              }
                            : null,
                        icon: Icon(
                          playing ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        )),
                  ),
                  IconButton(
                      onPressed: loaded
                          ? () async {
                              if (player.position.inSeconds + 10 <=
                                  player.duration!.inSeconds) {
                                await player.seek(Duration(
                                    seconds: player.position.inSeconds + 10));
                              } else {
                                await player.seek(const Duration(seconds: 0));
                              }
                            }
                          : null,
                      icon: const Icon(Icons.fast_forward_rounded)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class WaveBackground extends StatefulWidget {
  const WaveBackground({Key? key}) : super(key: key);

  @override
  State<WaveBackground> createState() => _WaveBackgroundState();
}

class _WaveBackgroundState extends State<WaveBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: CustomPaint(
        painter:
            WavePainter(controller: _controller, waves: 2, waveAmplitude: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: _buildAnimation,
    );
  }
}

class WavePainter extends CustomPainter {
  late final Animation<double> position;
  final Animation<double> controller;

  /// Number of waves to paint.
  final int waves;

  /// How high the wave should be.
  final double waveAmplitude;
  int get waveSegments => 2 * waves - 1;

  WavePainter(
      {required this.controller,
      required this.waves,
      required this.waveAmplitude}) {
    position = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.linear))
        .animate(controller);
  }

  void drawWave(Path path, int wave, size) {
    double waveWidth = size.width / waveSegments;
    double waveMinHeight = size.height / 2;

    double x1 = wave * waveWidth + waveWidth / 2;
    // Minimum and maximum height points of the waves.
    double y1 = waveMinHeight + (wave.isOdd ? waveAmplitude : -waveAmplitude);

    double x2 = x1 + waveWidth / 2;
    double y2 = waveMinHeight;

    path.quadraticBezierTo(x1, y1, x2, y2);
    if (wave <= waveSegments) {
      drawWave(path, wave + 1, size);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = GlobalVariables.primaryColor
      ..style = PaintingStyle.fill;

    // Draw the waves
    Path path = Path()..moveTo(0, size.height / 2);
    drawWave(path, 0, size);

    // Draw lines to the bottom corners of the size/screen with account for one extra wave.
    double waveWidth = (size.width / waveSegments) * 2;
    path
      ..lineTo(size.width + waveWidth, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    // Animate sideways one wave length, so it repeats cleanly.
    Path shiftedPath = path.shift(Offset(-position.value * waveWidth, 0));

    canvas.drawPath(shiftedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
