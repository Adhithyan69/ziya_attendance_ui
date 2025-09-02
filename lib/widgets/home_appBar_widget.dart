import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';
import 'package:ziya_attendance_ui/views/notification_screen.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});
  Route _createSlideRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NotificationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 00.8 + 20,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 00.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(30)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 45,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage(
                                TextConstants.profileImageUrl,
                              ),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstants.userName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          TextConstants.userField,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 9,
                right: 5,
                child: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/ziya_logo.jpg'),
                  radius: 22,
                ),
              ),
            ],
          ),
        ),
        // SizedBox(width: 20,),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createSlideRoute());
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: AppColors.buttonColor,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(Icons.notifications, size: 25, color: Colors.white),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
