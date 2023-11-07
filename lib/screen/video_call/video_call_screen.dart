import 'package:flutter/material.dart';
import 'package:flutter_first/screen/video_call/cam_screen.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Expanded(child: _Logo()),
            Expanded(child: _Image()),
            Expanded(child: _Button()),
          ],
        ),
      ),
    );
  }
}
class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!,
              blurRadius: 12,
              spreadRadius: 2
            )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(width: 12,),
              Text("Live",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 4
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
class _Image extends StatelessWidget {
  const _Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("asset/img/home_img.png"),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return CamScreen();
          }));
        }, child: Text("입장하기")),
      ],
    );
  }
}



