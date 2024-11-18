import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:pod_player/pod_player.dart';
import 'package:test_player/player_fitness_loading.dart';

class VimeoPod extends StatefulWidget {
  const VimeoPod({super.key, required this.vimeoId, required this.token});

  final String vimeoId;
  final String token;

  @override
  State<VimeoPod> createState() => _VimeoPodState();
}

class _VimeoPodState extends State<VimeoPod> {
  bool isInitial = false;

  PodPlayerController? controller;

  @override
  void initState() {
    print('__________________${widget.vimeoId}');
    controller = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(
        wakelockEnabled: true,
        autoPlay: true,
        isLooping: true,
        videoQualityPriority: [360],
      ),
      playVideoFrom: true
          ? PlayVideoFrom.dailymotion(
              widget.vimeoId,
              token: widget.token,
              videoPlayerOptions: VideoPlayerOptions(
                mixWithOthers: true,
              ),
            )
          : PlayVideoFrom.youtube(
              widget.vimeoId,
              videoPlayerOptions: VideoPlayerOptions(
                mixWithOthers: true,
              ),
            ),
    )..initialise().then((value) {
        setState(() => isInitial = true);
        controller!.play();
      });

    super.initState();
  }

  @override
  void dispose() {
    try {
      controller?.dispose();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (!isInitial)
        ? PlayerFitnessLoading()
        : Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PodVideoPlayer(
                  controller: controller!,
                  onToggleFullScreen: (isFullScreen) async {
                    if (isFullScreen) {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    } else {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                    }
                  },
                ),
              ],
            ),
          );
  }
}
