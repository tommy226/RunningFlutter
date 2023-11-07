import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({super.key, required this.video, required this.onNewVideoPressed});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = Duration();
  bool showControls = false;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.video.path != widget.video.path){
      initializeController();
    }
  }

  void initializeController() async {
    videoController = VideoPlayerController.file(File(widget.video.path));

    await videoController!.initialize();
    videoController!.addListener(() {
      final currentPosition = videoController!.value.position;
      setState(() {
        this.currentPosition = currentPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return CircularProgressIndicator();
    }

    return AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: GestureDetector(
          onTap: (){
            setState(() {
              showControls = !showControls;
            });
          },
          child: Stack(children: [
            VideoPlayer(videoController!),
            if(showControls)
            _Controls(
              onPlayPressed: onPlayPressed,
              onReversedPressed: onReversedPressed,
              onForwardPressed: onForwardPressed,
              isPlaying: videoController!.value.isPlaying,
            ),
            if(showControls)
            _NewVideo(
              onPressed: widget.onNewVideoPressed,
            ),
            _SliderBottom(
                currentPosition: currentPosition,
                maxPosition: videoController!.value.duration,
                onSlideChanged: (val) {
                  videoController!.seekTo(Duration(seconds: val.toInt()));
                })
          ]),
        ));
  }

  void onPlayPressed() {
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  void onReversedPressed() {
    final currentPosition = videoController!.value.position;

    Duration position = Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition;

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversedPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls(
      {super.key,
      required this.onPlayPressed,
      required this.onReversedPressed,
      required this.onForwardPressed,
      required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
              onPressed: onReversedPressed, iconData: Icons.rotate_left),
          renderIconButton(
              onPressed: onPlayPressed,
              iconData: isPlaying ? Icons.pause : Icons.play_arrow),
          renderIconButton(
              onPressed: onForwardPressed, iconData: Icons.rotate_right)
        ],
      ),
    );
  }

  Widget renderIconButton(
      {required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 30,
        color: Colors.white,
        icon: Icon(iconData));
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
          color: Colors.white,
          iconSize: 30,
          onPressed: onPressed,
          icon: Icon(Icons.photo_camera_back)),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSlideChanged;

  const _SliderBottom(
      {super.key,
      required this.currentPosition,
      required this.maxPosition,
      required this.onSlideChanged});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Text(
            "${currentPosition.inMinutes}: ${(currentPosition.inSeconds % 60).toString().padLeft(2, "0")}",
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
              child: Slider(
            max: maxPosition.inSeconds.toDouble(),
            min: 0,
            value: currentPosition.inSeconds.toDouble(),
            onChanged: onSlideChanged,
          )),
          Text(
            "${maxPosition.inMinutes}: ${(maxPosition.inSeconds % 60).toString().padLeft(2, "0")}",
            style: TextStyle(color: Colors.white),
          ),
        ]),
      ),
    );
  }
}
