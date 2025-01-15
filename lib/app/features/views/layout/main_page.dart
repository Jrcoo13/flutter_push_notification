import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/features/views/pages/home_page.dart';
import 'package:flutter_push_notification/app/features/views/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedBottonNavItem = 0; //base is home page
  final appScreens = [
    const HomePage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appScreens[selectedBottonNavItem],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory, // Removes tap effects
          highlightColor: Colors.transparent, // Removes highlight effects
        ),
        child: BottomNavigationBar(
          currentIndex: selectedBottonNavItem,
          onTap: selectedBottomNavItem,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }

  void selectedBottomNavItem(int index) {
    setState(() {
      selectedBottonNavItem = index;
    });
  }
}
