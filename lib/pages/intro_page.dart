import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
           onPressed: () async {
              await FirebaseAuth.instance.signOut();

              if (!mounted) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login', // or '/signup', whichever is your login route
                (route) => false,
              );
            },

            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/q_logo.png',
            fit: BoxFit.cover,
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0.6),
                  Colors.black.withOpacity(0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Glass card content
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: FadeTransition(
              opacity: _fadeIn,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Welcome $userName!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black45,
                            offset: Offset(3, 3),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Text(
                        'QUIZ APP',
                        style: GoogleFonts.rubik(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: const [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black54,
                              offset: Offset(4, 4),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/homepage');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          shadowColor: Colors.blueAccent.shade200,
                        ),
                        child: const Text('Start Quiz'),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
