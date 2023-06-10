import 'dart:ui';

import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex; // Add this property
  final Function(int) onTap; // Add this property

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  SizedBox _buildNavItem(int index, String iconPath) {
    return SizedBox(
      width: 42,
      height: 58,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              iconPath,
              color: widget.currentIndex == index
                  ? AppColors.accent1
                  : AppColors.textColor
            ),
            onPressed: () => widget.onTap(index),
            splashColor: Colors.transparent,
          ),
          if (widget.currentIndex == index)
            Positioned(
              top: 0,
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent1,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            clipBehavior: Clip.none,
            color: Colors.transparent,
            width: size.width,
            height: size.height * 0.11,
            child: Stack(
              children: [
                ClipPath(
                  clipper: RPSCustomShapeClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.14,
                      decoration: BoxDecoration(
                        color: Color(0xFFACA9D5).withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
                Center(
                  heightFactor: 0.2,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accent1,
                      // gradient: LinearGradient(
                      //   begin: Alignment(0.00, -1.00),
                      //   end: Alignment(1.00, 1.00),
                      //   colors: [
                      //     Color(0xFFBBB9FF),
                      //     Color(0xFFDCE5FC),
                      //   ],
                      //   stops: [0.00, 0.60],
                      // ),
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0.1,
                      onPressed: ()=> Navigator.pushNamed(context, '/qrscreen') ,
                      child: SvgPicture.asset(
                        'assets/images/icons/Scan.svg',
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0, 'assets/images/icons/Home.svg'),
                      _buildNavItem(1, 'assets/images/icons/Analytics.svg'),
                      Container(width: size.width * 0.15),
                      _buildNavItem(2, 'assets/images/icons/Payments.svg'),
                      _buildNavItem(3, 'assets/images/icons/More.svg'),
                    ],
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

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3024224, 0);
    path_0.lineTo(size.width * 0.1628499, 0);
    path_0.cubicTo(size.width * 0.1058471, 0, size.width * 0.07734555, 0,
        size.width * 0.05557354, size.height * 0.05011195);
    path_0.cubicTo(
        size.width * 0.03642214,
        size.height * 0.09419161,
        size.width * 0.02085158,
        size.height * 0.1645276,
        size.width * 0.01109349,
        size.height * 0.2510391);
    path_0.cubicTo(0, size.height * 0.3493885, 0, size.height * 0.4781368, 0,
        size.height * 0.7356322);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height * 0.7356322);
    path_0.cubicTo(
        size.width,
        size.height * 0.4781368,
        size.width,
        size.height * 0.3493885,
        size.width * 0.9889059,
        size.height * 0.2510391);
    path_0.cubicTo(
        size.width * 0.9791476,
        size.height * 0.1645276,
        size.width * 0.9635776,
        size.height * 0.09419161,
        size.width * 0.9444275,
        size.height * 0.05011195);
    path_0.cubicTo(size.width * 0.9226539, 0, size.width * 0.8941527, 0,
        size.width * 0.8371501, 0);
    path_0.lineTo(size.width * 0.6868779, 0);
    path_0.cubicTo(
        size.width * 0.6417150,
        size.height * 0.01737149,
        size.width * 0.6212188,
        size.height * 0.1510437,
        size.width * 0.6006590,
        size.height * 0.2851069);
    path_0.cubicTo(
        size.width * 0.5784809,
        size.height * 0.4297437,
        size.width * 0.5562316,
        size.height * 0.5748356,
        size.width * 0.5028677,
        size.height * 0.5748356);
    path_0.cubicTo(
        size.width * 0.4520916,
        size.height * 0.5748356,
        size.width * 0.4303944,
        size.height * 0.4434874,
        size.width * 0.4077099,
        size.height * 0.3061563);
    path_0.cubicTo(
        size.width * 0.3844504,
        size.height * 0.1653632,
        size.width * 0.3601552,
        size.height * 0.01828126,
        size.width * 0.3024224,
        0);
    path_0.close();

    Paint paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.transparent;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0.3024224, 0);
    path.lineTo(size.width * 0.1628499, 0);
    path.cubicTo(
      size.width * 0.1058471,
      0,
      size.width * 0.07734555,
      0,
      size.width * 0.05557354,
      size.height * 0.05011195,
    );
    path.cubicTo(
      size.width * 0.03642214,
      size.height * 0.09419161,
      size.width * 0.02085158,
      size.height * 0.1645276,
      size.width * 0.01109349,
      size.height * 0.2510391,
    );
    path.cubicTo(
      0,
      size.height * 0.3493885,
      0,
      size.height * 0.4781368,
      0,
      size.height * 0.7356322,
    );
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.7356322);
    path.cubicTo(
      size.width,
      size.height * 0.4781368,
      size.width,
      size.height * 0.3493885,
      size.width * 0.9889059,
      size.height * 0.2510391,
    );
    path.cubicTo(
      size.width * 0.9791476,
      size.height * 0.1645276,
      size.width * 0.9635776,
      size.height * 0.09419161,
      size.width * 0.9444275,
      size.height * 0.05011195,
    );
    path.cubicTo(
      size.width * 0.9226539,
      0,
      size.width * 0.8941527,
      0,
      size.width * 0.8371501,
      0,
    );
    path.lineTo(size.width * 0.6868779, 0);
    path.cubicTo(
      size.width * 0.6417150,
      size.height * 0.01737149,
      size.width * 0.6212188,
      size.height * 0.1510437,
      size.width * 0.6006590,
      size.height * 0.2851069,
    );
    path.cubicTo(
      size.width * 0.5784809,
      size.height * 0.4297437,
      size.width * 0.5562316,
      size.height * 0.5748356,
      size.width * 0.5028677,
      size.height * 0.5748356,
    );
    path.cubicTo(
      size.width * 0.4520916,
      size.height * 0.5748356,
      size.width * 0.4303944,
      size.height * 0.4434874,
      size.width * 0.4077099,
      size.height * 0.3061563,
    );
    path.cubicTo(
      size.width * 0.3844504,
      size.height * 0.1653632,
      size.width * 0.3601552,
      size.height * 0.01828126,
      size.width * 0.3024224,
      0,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

