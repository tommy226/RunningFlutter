import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/screen/video_call/agora.dart';
import 'package:permission_handler/permission_handler.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? rtcEngine;

  // 내 id
  int? uid = 0;

  // 상대 아이디
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIVE"),
      ),
      body: FutureBuilder<bool>(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Expanded(child: renderMainView()),
                ElevatedButton(onPressed: () async{
                  if(rtcEngine != null){
                    await rtcEngine!.leaveChannel();
                  }

                  Navigator.of(context).pop();
                }, child: Text("채널 나가기"))

              ],
            );
          }),
    );
  }

  renderMainView() {
    if (uid == null) {
      return Center(
        child: Text("채널에 참여해주세요"),
      );
    } else {
      return AgoraVideoView(
          controller: VideoViewController(
              rtcEngine: rtcEngine!, canvas: VideoCanvas(uid: 0)));
    }
  }

  renderSubView() {}

  Future<bool> init() async {
    final response = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = response[Permission.camera];
    final micPermission = response[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw "카메라 또는 마이크 권한이 없습니다.";
    }

    if (rtcEngine == null) {
      rtcEngine = createAgoraRtcEngine();

      await rtcEngine!.initialize(RtcEngineContext(
        appId: APP_ID,
      ));

      rtcEngine!.registerEventHandler(RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print("채널 입장 uid : ${connection.localUid}");
        setState(() {
          uid = connection.localUid;
        });
      }, onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print("채널 퇴장 ");
        setState(() {
          uid = null;
        });
      }, onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        print("상대가 채널에 입장하였습니다 other uid : ${remoteUid}");
        setState(() {
          otherUid = remoteUid;
        });
      }, onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
        print("상대가 나갔습니다. other uid : ${remoteUid}");
        setState(() {
          otherUid = null;
        });
      }));

      await rtcEngine!.enableAudio();
      await rtcEngine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await rtcEngine!.joinChannel(
          token: TEMP_TOKEN, channelId: CHANNEL_NAME, uid: 0, options: options);
    }

    return true;
  }
}
