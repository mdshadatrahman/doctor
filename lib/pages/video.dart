import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;


const APP_ID = "21616b2145994f2fadd64a615486b35c";
const Token = "00621616b2145994f2fadd64a615486b35cIACbL7QSkAQlkHOOdkdsCZxG7d04PB5yT8JhGhk6C+jG/doowPsAAAAAEAAPHFzYSIHpYAEAAQA5gelg";



class VideoCallingSystem extends StatefulWidget {
  ClientRole role;
  @override
  _VideoCallingSystemState createState() => _VideoCallingSystemState();
}
class _VideoCallingSystemState extends State<VideoCallingSystem> {
  int _remoteUid;
  RtcEngine _engine;
  bool muted = false;
  
  
  @override
  void dispose(){
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    initForAgora();
  }
  Future <void> initForAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(APP_ID));

    await _engine.enableVideo();

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed){
          print("Local user $uid joined");
        },
        userJoined: (int uid, int elapsed){
          print("Remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason){
          print("Remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        }
      ),
    );
    await _engine.joinChannel(Token, 'sr', null, 0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DocCall'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 100,
              child: _renderLocalPreview(),
            ),
          ),
          _toolbar(),
        ],
      ),
      
    );
  }

  //current user video
  Widget _renderLocalPreview(){
    return RtcLocalView.SurfaceView();
  }

  //remote user video
  Widget _renderRemoteVideo(){
    if(_remoteUid != null){
      return RtcRemoteView.SurfaceView(uid: _remoteUid,);
    } else {
      return Text(
        'Please wait for the doctor to join',
        textAlign: TextAlign.center,
      );
    }
  }
    /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}