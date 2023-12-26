import 'dart:async';


import 'package:test7/utils/EAColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:test7/screens/login.dart';

import '../utils/EADataProvider.dart';
import 'EASelectCityScreen.dart';

class EAWalkThroughScreen extends StatefulWidget {
  const EAWalkThroughScreen({Key? key}) : super(key: key);

  @override
  _EAWalkThroughScreenState createState() => _EAWalkThroughScreenState();
}

class _EAWalkThroughScreenState extends State<EAWalkThroughScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: context.width(),
                  height: context.height(),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: walkThroughList.length,
                    itemBuilder: (context, i) {
                      return Image.asset(
                          'images/sidibou.jpg', fit: BoxFit.cover);
                    },
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value);
                    },
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 40,
                  child: Text(
                    'Get Started',
                    style: primaryTextStyle(color: Colors.white, size: 24),
                  ).onTap(() {}),
                ),
                Text(

                  'Get Started',
                  style: primaryTextStyle(color: Colors.white, size: 24),
                ).onTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }),
                Positioned(
                  bottom: 40,
                  child: Container(
                    width: context.width(),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Tunisia Events!',
                          style: boldTextStyle(size: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Discover a world of exciting events and experiences with the Tunisia Events app. Your gateway to a vibrant community where you can find your guide to your chosen events, connect with fellow attendees, and share your experiences.',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Key Features:',
                          style: boldTextStyle(size: 24, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '- Explore a diverse range of events happening around you.',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '- Get detailed guides for each event to enhance your experience.',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '- Connect with people attending the same events and build meaningful connections.',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '- Share your thoughts and feedback to create a dynamic event community.',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'About Us:',
                          style: boldTextStyle(size: 24, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tunisia Events is designed to make your event journey seamless and enjoyable. Developed with passion and expertise by Mannoubi Salim and Wassim, our app is here to redefine the way you experience and engage with events.',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Join us on this exciting journey, and let Tunisia Events be your companion in creating unforgettable memories at every event!',
                          style: primaryTextStyle(color: Colors.white,
                              size: 18),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }}