import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:permission_handler/permission_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/chat_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/seller_info.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

import 'call/call.dart';

class VideoChatScreen extends StatefulWidget {
  final SellerModel seller;
  final Customer customer;
  final int id;
  final Call call;

  const VideoChatScreen(
      {Key key, this.seller, this.call, this.customer, this.id})
      : super(key: key);
  @override
  State<VideoChatScreen> createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  static String get appUid => AppConstants.appId;
  static String get token => AppConstants.token;
  int _remoteUid = VideoChatScreen().id;




  @override
  Widget build(BuildContext context) {
    AgoraClient  client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appUid,
        tempToken: token,
        channelName: widget.seller.id.toString(),
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );

    return Scaffold(
      body: Stack(
        children: [
          AgoraVideoViewer(
            client: client,
            layoutType: Layout.grid,
            showNumberOfUsers: true,
          ),
          AgoraVideoButtons(
            client: client,
          ),
          // Center(
          //   child: _renderRemoteVideo(),
          // ),
          // Align(
          //     alignment: Alignment.topLeft,
          //     child: Container(
          //         height: 200, width: 200, child: _renderLocalPreview()))
        ],
      ),
    );
  }

// current user video
  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }

// remote user video
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        "Please wait for the other user",
        textAlign: TextAlign.center,
      );
    }
  }
}
