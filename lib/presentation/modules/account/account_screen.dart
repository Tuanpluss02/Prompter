import 'package:base/app/utils/extension.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/widgets/global/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_controller.dart';

class AccountScreen extends BaseScreen<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          _buildFirstSection(),
          _buildUserInfo(),
        ]));
  }

  SizedBox _buildFirstSection() {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: [
          _buildBackgroundImg(),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment(0, 0.2), end: Alignment.bottomCenter, colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.6),
            ])),
          ),
          _buildAvatarName(),
        ],
      ),
    );
  }

  Align _buildAvatarName() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: NetworkImage('https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            SizedBox(width: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Son Tung MTP\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextSpan(text: '@sontungmtp', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppImage _buildBackgroundImg() {
    return AppImage(fit: BoxFit.contain, image: NetworkImage('https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'));
  }

  _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReach(),
          _buildFollowButton(),
          Expanded(child: _buildUserPostMedia()),
        ],
      ),
    );
  }

  Row _buildReach() {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (count: 15000, title: 'Likes'),
          (count: 15000, title: 'Followers'),
          (count: 15000, title: 'Following'),
        ].map((item) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: item.count.toShortString() + ' ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextSpan(
                    text: item.title,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }).toList());
  }

  _buildFollowButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '+ Follow',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  _buildUserPostMedia() {
    return Column(
      children: [
        SizedBox(
          width: Get.width * 0.6,
          child: TabBar(dividerColor: Colors.transparent, controller: controller.tabController, tabs: [
            Tab(
              child: Text('All', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            Tab(
              child: Text('Videos', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            Tab(
              child: Text('Images', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ]),
        ),
        SingleChildScrollView(
          child: TabBarView(controller: controller.tabController, children: [
            _buildAllMedia(),
            _buildVideos(),
            _buildImages(),
          ]),
        ),
      ],
    );
  }

  _buildAllMedia() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Item $index'),
            ),
          );
        });
  }

  _buildVideos() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Item $index'),
            ),
          );
        });
  }

  _buildImages() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Item $index'),
            ),
          );
        });
  }
}
