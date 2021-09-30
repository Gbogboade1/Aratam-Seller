

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/call/call_methods.dart';
import 'package:sixvalley_vendor_app/data/model/response/chat_model.dart';

import '../videochat_screen.dart';
import 'call.dart';


class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({Customer from, Customer to, context}) async {
    Call call = Call(
      callerId: from.id.toString(),
      callerName: from.fName,
      callerPic: from.image,
      receiverId: to.id.toString(),
      receiverName: to.fName,
      receiverPic: to.image,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoChatScreen(call: call),
          ));
    }
  }
}
