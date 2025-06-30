import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'leave_screen.dart';
import 'profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Widget _buildOffstageNavigator(int index, Widget child) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) => MaterialPageRoute(
          builder: (_) => child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
          } else {
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(0, const HomeScreen()),
            _buildOffstageNavigator(1, const HistoryScreen()),
            _buildOffstageNavigator(2, const LeaveScreen()),
            _buildOffstageNavigator(3, const ProfileScreen()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (_currentIndex == index) {
              _navigatorKeys[index]
                  .currentState!
                  .popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_right),
              label: 'Leave',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
