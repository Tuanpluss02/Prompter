import 'package:base/app/constants/app_color.dart';
import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_controller.dart';

class AccountScreen extends BaseScreen<AccountController> {
  const AccountScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Account',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          )),
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      SizedBox(height: 20),
      CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
      SizedBox(height: 20),
      Text(
        'John Doe',
      )
    ]));
  }
}
