import 'package:flutter/material.dart';
import 'package:usluge_client/constant.dart';
import 'package:usluge_client/screen/form/form.dart';
import 'package:usluge_client/screen/main/pages/chat.dart';
import 'package:usluge_client/screen/main/pages/dashboard/dashboard.dart';
import 'package:usluge_client/screen/main/pages/profile.dart';
import 'package:usluge_client/screen/main/pages/setting.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Chat(),
    const Profile(),
    const Setting()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => SendForm())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const Dashboard();
                              currentTab = 0;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: currentTab == 0
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                Text(
                                  "Usluge",
                                  style: TextStyle(
                                      color: currentTab == 0
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ])),
                      MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const Chat();
                              currentTab = 1;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: currentTab == 1
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                Text(
                                  "Chat",
                                  style: TextStyle(
                                      color: currentTab == 1
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ])),
                    ],
                  ),
                  // Right Tab Bar Icons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const Setting();
                              currentTab = 2;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: currentTab == 2
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                Text(
                                  "Setting",
                                  style: TextStyle(
                                      color: currentTab == 2
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ])),
                      MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const Profile();
                              currentTab = 3;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: currentTab == 3
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: currentTab == 3
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ])),
                    ],
                  ),
                ])),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: mBackgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: Text("Lista rezervisanih usluga",
          style: TextStyle(
            color: mPrimaryColor,
          )),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ));
}
