import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testproject/widgets/slide_to_act.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>(debugLabel: UniqueKey().toString());
  bool isAnswerRevealed = false;
  bool isRevealPhotos = false;
  @override
  Widget build(BuildContext context) {
    bool showBackgroundImage = !isAnswerRevealed || (isAnswerRevealed && isRevealPhotos);
    bool isShowContent = !showBackgroundImage && !isAnswerRevealed;
    log(
      'Rebuilding ScreenTwo:\n isAnswerRevealed=$isAnswerRevealed,\n isRevealPhotos=$isRevealPhotos'
      '\n showBackgroundImage=$showBackgroundImage,\n isShowContent=$isShowContent',
    );
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 72, 29, 29),
          image: showBackgroundImage
              ? const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderPart(
                    isAnswerRevealed: isAnswerRevealed,
                    showBackgroundImage: showBackgroundImage,
                    onBackPress: () {
                      setState(() {
                        isAnswerRevealed = false;
                        isRevealPhotos = false;
                      });
                    },
                  ),
                  Expanded(
                    child: !showBackgroundImage
                        ? _buildMiddleContainer()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Unlock For One Reveal',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: Colors.white.withOpacity(0.55),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: Colors.white.withOpacity(0.35),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: Colors.white.withOpacity(0.35),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF9FB2C1).withOpacity(0.85),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Icon(
                                              Icons.all_inclusive,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '2 Reveals Left',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        circleIcon(
                                          icon: Icons.close,
                                          onTap: () {},
                                        ),
                                        const SizedBox(width: 12),
                                        circleIcon(
                                          icon: Icons.favorite_border,
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                  ),
                  _buildBottomAppBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color.fromARGB(221, 63, 63, 63),
          size: 30,
        ),
      ),
    );
  }

  Column _buildMiddleContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isAnswerRevealed)
                Text(
                  'QUESTION',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              if (isAnswerRevealed)
                Row(
                  children: [
                    Icon(
                      Icons.swipe_right,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'SWIPE TO READ MORE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              Text(
                'If you had to re-live a day in your past, '
                'which day would you choose and why?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isAnswerRevealed ? 32 : 26,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              if (!isAnswerRevealed) Divider(),
              if (isAnswerRevealed)
                SizedBox(
                  height: 10,
                ),
              if (isAnswerRevealed)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Colors.white.withOpacity(0.55),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Colors.white.withOpacity(0.35),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Colors.white.withOpacity(0.35),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),
              Text(
                !isAnswerRevealed
                    ? 'At this stage of my life, I’ve come to realize '
                          'that I am awesome. It has been so refreshing to…'
                    : 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SlideAction(
                height: 60,
                key: key,
                reversed: false,
                onSubmit: () async {
                  await Future.delayed(const Duration(milliseconds: 300));

                  if (!isAnswerRevealed) {
                    isAnswerRevealed = true;
                    setState(() {});
                    key.currentState!.reset();
                  } else if (!isRevealPhotos) {
                    isRevealPhotos = true;
                    setState(() {});
                    key.currentState!.reset();
                  }
                },
                outerColor: const Color.fromARGB(255, 238, 237, 237),
                text: !isAnswerRevealed ? 'Reveal Answer (02)' : 'Reveal Photos',
                icon: Icons.arrow_forward,
                textColor: Colors.black,
                innerColor: Colors.black,
              ),

              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Not For Me',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Padding _buildHeaderPart({
    required bool isAnswerRevealed,
    required bool showBackgroundImage,
    required Function()? onBackPress,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: !showBackgroundImage
          ? Column(
              children: [
                if (!isAnswerRevealed)
                  Row(
                    children: [
                      Text(
                        "Nik 28",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.verified,
                        color: const Color(0xFF81A3DE),
                        size: 20,
                      ),
                    ],
                  ),
                if (isAnswerRevealed) SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isAnswerRevealed)
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        if (isAnswerRevealed)
                          GestureDetector(
                            onTap: onBackPress,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        SizedBox(width: 4),
                        if (!isAnswerRevealed)
                          Text(
                            "info",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.ios_share_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                if (!isAnswerRevealed)
                  Divider(
                    color: Colors.white54,
                    thickness: 1,
                  ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isRevealPhotos = false;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swipe,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "SWIPE BETWEEN PHOTOS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
    );
  }

  Padding _buildBottomAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.people,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.supervised_user_circle_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
