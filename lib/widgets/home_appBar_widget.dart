import 'package:flutter/material.dart';
import 'package:ziya_attendance_ui/constants/color_constants.dart';
import 'package:ziya_attendance_ui/constants/text_constants.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextConstants.profileImageUrl != null &&
                          TextConstants.profileImageUrl!.isNotEmpty
                          ? Image.network(
                        TextConstants.profileImageUrl!,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        },
                      )
                          : Container(),
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
                            color: Colors.white,
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
        Container(
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
      ],
    );
  }
}