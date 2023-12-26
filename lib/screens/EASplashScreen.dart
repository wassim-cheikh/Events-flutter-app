import 'package:test7/utils/EAColors.dart';
import 'package:test7/utils/EAImages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'EAWalkThroughScreen.dart';

class EASplashScreen extends StatefulWidget {
  const EASplashScreen({Key? key}) : super(key: key);

  @override
  _EASplashScreenState createState() => _EASplashScreenState();
}

class _EASplashScreenState extends State<EASplashScreen> {
  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {
    setStatusBarColor(transparentColor);
    await 3.seconds.delay;
    finish(context);
    const EAWalkThroughScreen().launch(context, isNewTask: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: context.width(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(event_ic_logo, height: 200, fit: BoxFit.cover),
            20.height,
            Text('Tunisia Events', style: GoogleFonts.acme(fontSize: 40, color: primaryColor1)),
            20.height,
            Text('Event Discovery & Booking ', style: primaryTextStyle()),
          ],
        ),
      ),
    );
  }
}
