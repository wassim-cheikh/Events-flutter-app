
import 'package:test7/utils/EAColors.dart';
import 'package:test7/utils/EADataProvider.dart';
import 'package:test7/utils/EAapp_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:test7/screens/EventsFeed.dart'; // Make sure to import eventsFeed.dart
class EASelectHashtagScreen extends StatefulWidget {
  final String username;
  final String city;

  EASelectHashtagScreen({required this.username, required this.city});

  @override
  _EASelectHashtagScreenState createState() => _EASelectHashtagScreenState();
}
class _EASelectHashtagScreenState extends State<EASelectHashtagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Select Event Type ", backWidget: BackButton(color: white)),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 80),
            child: Wrap(
              runSpacing: 12,
              spacing: 16,
              children: List.generate(
                hashtagList.length,
                    (index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(hashtagList[index].image!, height: 250, width: context.width() * 0.43, fit: BoxFit.cover).cornerRadiusWithClipRRect(16),
                            Container(
                              height: 250,
                              width: context.width() * 0.43,
                              decoration: boxDecorationWithRoundedCorners(
                                borderRadius: radius(16),
                                gradient: hashtagList[index].selectHash == true
                                    ? LinearGradient(colors: [primaryColor1.withOpacity(0.4), primaryColor2.withOpacity(0.4)])
                                    : LinearGradient(colors: [transparentColor, transparentColor]),
                              ),
                            ),
                            Icon(Icons.check_circle_outline, size: 30, color: hashtagList[index].selectHash == true ? white : transparentColor)
                          ],
                        ),
                        10.height,
                        Text(hashtagList[index].name!, style: boldTextStyle()).paddingLeft(8),
                        Text(hashtagList[index].subtitle!, style: secondaryTextStyle()).paddingLeft(8),
                      ],
                    ),
                  ).onTap(() {
                    // Deselect all types
                    hashtagList.forEach((hashtag) {
                      hashtag.selectHash = false;
                    });

                    // Select the tapped type
                    hashtagList[index].selectHash = true;
                    setState(() {});
                  });
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              width: context.width(),
              height: 50,
              decoration: boxDecorationWithShadow(borderRadius: radius(24), gradient: LinearGradient(colors: [primaryColor1, primaryColor2])),
              child: Text("Let's start!".toUpperCase(), style: boldTextStyle(color: white, size: 18)),
            ).onTap(() {
              // Get the selected type
              String selectedType = hashtagList.firstWhere((hashtag) => hashtag.selectHash == true, orElse: () => hashtagList.first).name!;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsFeed(
                    username: widget.username,
                    city: widget.city, // assuming you have a variable called city in EASelectHashtagScreen
                    type: selectedType,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

