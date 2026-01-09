import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testproject/screens/screen_one.dart';
import 'package:testproject/widgets/logo_painter.dart';
import 'package:testproject/widgets/slide_to_act.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool _showNotificationDialog = true;
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>(debugLabel: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    return Material(
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(child: Icon(Icons.image, size: 100, color: Colors.white30)),
                );
              },
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ),

          // Notification Dialog
          if (_showNotificationDialog)
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.grey[800]?.withOpacity(0.4), borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notifications_outlined, color: Colors.grey[300], size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Intentional reminders at good times.\nAllow notifications?',
                                style: TextStyle(color: Colors.grey[200], fontSize: 16, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showNotificationDialog = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[900],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text('Yes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showNotificationDialog = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[700]?.withOpacity(0.6),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text('Not Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Bottom content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.9)],
                  stops: const [0.0, 0.3, 1.0],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: CustomPaint(size: const Size(40, 40), painter: LogoPainter()),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    "Let's start with you first, Jordan",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600, height: 1.3),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Answer a few quick questions to personalize your experience. It should only take about 12 minutes.',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 32),

                  SlideAction(
                    height: 60,
                    key: key,
                    reversed: false,
                    onSubmit: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      if (context.mounted) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenOne()));
                      }
                      key.currentState!.reset();
                    },
                    outerColor: const Color.fromARGB(255, 238, 237, 237),
                    text: 'Set Your Profile',
                    textColor: Colors.black,
                    icon: Icons.arrow_forward,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
