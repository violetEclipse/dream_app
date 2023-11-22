import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/setting_row.dart';
import '../../common_widget/title_subtitle_cell.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:http/http.dart' as http;

// TitleSubtitleCell remains the same...

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<List<Map<String, dynamic>>> personData;
  late Timer timer;
  List accountArr = [
    {"image": "assets/img/p_personal.png", "name": "Personal Data", "tag": "1"},
    {"image": "assets/img/p_achi.png", "name": "Achievement", "tag": "2"},
    {
      "image": "assets/img/p_activity.png",
      "name": "Activity History",
      "tag": "3"
    },
    {
      "image": "assets/img/p_workout.png",
      "name": "Workout Progress",
      "tag": "4"
    }
  ];

  List otherArr = [
    {"image": "assets/img/p_contact.png", "name": "Contact Us", "tag": "5"},
    {"image": "assets/img/p_privacy.png", "name": "Privacy Policy", "tag": "6"},
    {"image": "assets/img/p_setting.png", "name": "Setting", "tag": "7"},
  ];

  @override
  void initState() {
    super.initState();
    // Initial data fetch
    personData = fetchPersonData();
    // Timer to refresh data every 5 seconds
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        personData = fetchPersonData();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchPersonData() async {
    final response =
        // 888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
        // 888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
        // 888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
        await http.get(Uri.parse('http://192.168.43.215:8000/api/persons'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load person data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: personData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              List<Map<String, dynamic>> persons = snapshot.data!;
              bool positive = false;

// 88888888888888888888888888888888888888888888888888

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/img/u2.png",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dream © 2023  Inc.",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "health sleep",
                              style: TextStyle(
                                color: TColor.gray,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          // Your existing code for the Edit button...
                          ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Displaying the three cards in a single row
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: persons.map((person) {
                                return Expanded(
                                  child: TitleSubtitleCell(
                                    title: person['name']
                                        .toString(), // Replace with the appropriate field
                                    subtitle: 'name'
                                        .toString(), // Replace with the appropriate field
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: persons.map((person) {
                                return Expanded(
                                  child: TitleSubtitleCell(
                                    title: person['age']
                                        .toString(), // Replace with the appropriate field
                                    subtitle: 'age'
                                        .toString(), // Replace with the appropriate field
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: persons.map((person) {
                                return Expanded(
                                  child: TitleSubtitleCell(
                                    title: person['sex']
                                        .toString(), // Replace with the appropriate field
                                    subtitle: 'sex'
                                        .toString(), // Replace with the appropriate field
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

// 8888888888888888888888888888888888888888888888888888888

                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: TColor.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: accountArr.length,
                          itemBuilder: (context, index) {
                            var iObj = accountArr[index] as Map? ?? {};
                            return SettingRow(
                              icon: iObj["image"].toString(),
                              title: iObj["name"].toString(),
                              onPressed: () {},
                            );
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: TColor.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notification",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 30,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/img/p_notification.png",
                                    height: 15, width: 15, fit: BoxFit.contain),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    "Pop-up Notification",
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                CustomAnimatedToggleSwitch<bool>(
                                  current: positive,
                                  values: [false, true],
                                  dif: 0.0,
                                  indicatorSize: Size.square(30.0),
                                  animationDuration:
                                      const Duration(milliseconds: 200),
                                  animationCurve: Curves.linear,
                                  onChanged: (b) =>
                                      setState(() => positive = b),
                                  iconBuilder: (context, local, global) {
                                    return const SizedBox();
                                  },
                                  defaultCursor: SystemMouseCursors.click,
                                  onTap: () =>
                                      setState(() => positive = !positive),
                                  iconsTappable: false,
                                  wrapperBuilder: (context, global, child) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            left: 10.0,
                                            right: 10.0,
                                            height: 30.0,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: TColor.secondaryG),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50.0)),
                                              ),
                                            )),
                                        child,
                                      ],
                                    );
                                  },
                                  foregroundIndicatorBuilder:
                                      (context, global) {
                                    return SizedBox.fromSize(
                                      size: const Size(10, 10),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: TColor.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50.0)),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black38,
                                                spreadRadius: 0.05,
                                                blurRadius: 1.1,
                                                offset: Offset(0.0, 0.8))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: TColor.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: otherArr.length,
                          itemBuilder: (context, index) {
                            var iObj = otherArr[index] as Map? ?? {};
                            return SettingRow(
                              icon: iObj["image"].toString(),
                              title: iObj["name"].toString(),
                              onPressed: () {},
                            );
                          },
                        )
                      ],
                    ),
                  )

                  //Your remaining code...
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
