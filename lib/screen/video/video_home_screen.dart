import 'package:flutter/material.dart';
import 'package:flutter_first/component/custom_video_player.dart';
import 'package:image_picker/image_picker.dart';

class VideoHomeScreen extends StatefulWidget {
  const VideoHomeScreen({super.key});

  @override
  State<VideoHomeScreen> createState() => _VideoHomeScreenState();
}

class _VideoHomeScreenState extends State<VideoHomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: video == null ? renderEmpty() : Center(child: renderVideo())
    );
  }

  Widget renderVideo(){
    return CustomVideoPlayer(
      video: video!, onNewVideoPressed: onNewVideoPressed,
    );
  }

  Widget renderEmpty() {
    final style = TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onTab: onNewVideoPressed),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Video",
                style: style,
              ),
              Text(
                "PLAYER",
                style: style.copyWith(fontWeight: FontWeight.w900),
              )
            ],
          )
        ],
      ),
    );
  }

  void onNewVideoPressed() async{
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(video != null){
      setState(() {
        this.video = video;
      });
    }
  }

  getBoxDecoration() => BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2A3A7c), Color(0xFF000118)]));
}

class _Logo extends StatelessWidget {
  final VoidCallback onTab;

  const _Logo({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTab, child: Image.asset("asset/img/logo.png"));
  }
}
