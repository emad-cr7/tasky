import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/profile/profile.dart';
import 'package:tasky/features/tasks/to_do_completed.dart';
import '../tasks/to_do.dart';
import '../home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    ToDo(),
    ToDoCompleted(),
    Profile(),
  ];

  int _crrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _crrentIndex,
        onTap: (int? index) {
          setState(() {
            _crrentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/home.svg", 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/to_do.svg", 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/to_do_completed.svg", 2),

            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/profiel.svg", 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screen[_crrentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path, int crrentIndex) => SvgPicture.asset(
    path,
    colorFilter: ColorFilter.mode(
      _crrentIndex == crrentIndex
          ? Color(0xff15B86C)
          : ThemeController.isDark()
          ? Color(0xffC6C6C6)
          : Color(0xff3A4640),
      BlendMode.srcIn,
    ),
  );
}
