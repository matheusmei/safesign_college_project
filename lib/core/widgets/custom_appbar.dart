import 'package:flutter/material.dart';
import '../theme/colors_app.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: ColorsApp.appGrey,
      title: SizedBox(
        child: Hero(
          tag: "logo",
          child: Image.asset(
            'image/NewLogoSafeSign.png',
            height: 100,
            width: 100,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icon(
            Icons.account_circle_rounded,
            color: ColorsApp.appLightGrey,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}
