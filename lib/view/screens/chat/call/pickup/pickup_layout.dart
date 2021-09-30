import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/model/response/seller_info.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

import '../call.dart';
import '../call_methods.dart';
import 'pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final SellerModel seller;
  final CallMethods callMethods = CallMethods();
  final SharedPreferences sharedPreferences;

  PickupLayout({
    @required this.scaffold,
    this.sharedPreferences, this.seller,
  });

  String get uid => seller.id ?? '';
  @override
  Widget build(BuildContext context) {
    return (uid != null)
        ? StreamBuilder(
            stream: callMethods.callStream(uid: uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data != null) {
                Call call = Call.fromMap(snapshot.data.data);

                if (!call.hasDialled) {
                  return PickupScreen(call: call);
                }
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
