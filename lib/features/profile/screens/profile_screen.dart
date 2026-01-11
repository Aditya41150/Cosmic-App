import 'dart:ui';
import 'dart:math';
import 'package:cosmic/core/services/auth_service.dart';
import 'package:cosmic/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. FULL SCREEN BACKDROP
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 20 + bottomPadding),
                  child: Column(
                    children: [
                      /// APP BAR
                      _GlassContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            _CircleButton(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.pop(context),
                            ),
                            const Spacer(),
                            const Text(
                              "My Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(width: 44),
                          ],
                        ),
                      ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                      const SizedBox(height: 25),

                      /// PROFILE CARD
                      _GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage('assets/profile.png'),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Arthur Morgan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Space adventurer",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, color: Colors.white),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.1),

                      const SizedBox(height: 20),

                      /// TOGGLE
                      _GlassContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Show planetary progress",
                              style: TextStyle(color: Colors.white),
                            ),
                            Switch(
                              value: true,
                              onChanged: (_) {},
                              activeColor: Colors.cyanAccent,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1),

                      const SizedBox(height: 30),

                      /// ANIMATED PROGRESS
                      _GlassContainer(
                        padding: const EdgeInsets.all(24),
                        child: const AnimatedGradientCircularProgress(
                          targetProgress: 0.871,
                        ),
                      ).animate().fadeIn(delay: 300.ms).scale(),

                      const SizedBox(height: 25),

                      /// CHECKBOXES
                      _GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            _CheckItem(
                              title: "Show me in Planet Rating",
                              value: true,
                            ),
                            SizedBox(height: 10),
                            _CheckItem(title: "Notifications", value: true),
                          ],
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                      const SizedBox(height: 30),

                      /// LOGOUT BUTTON
                      InkWell(
                        onTap: () async {
                          await authService.signOut();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (route) => false,
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: Colors.redAccent),
                              SizedBox(width: 10),
                              Text(
                                "Log Out",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ======================================================
/// 🎬 ANIMATED PROGRESS
/// ======================================================

class AnimatedGradientCircularProgress extends StatefulWidget {
  final double targetProgress;

  const AnimatedGradientCircularProgress({
    super.key,
    required this.targetProgress,
  });

  @override
  State<AnimatedGradientCircularProgress> createState() =>
      _AnimatedGradientCircularProgressState();
}

class _AnimatedGradientCircularProgressState
    extends State<AnimatedGradientCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.targetProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return GradientCircularProgress(
          progress: _animation.value,
          percentageText: "${(_animation.value * 100).toStringAsFixed(1)}%",
        );
      },
    );
  }
}

/// ======================================================
/// 🎨 GRADIENT CIRCLE
/// ======================================================

class GradientCircularProgress extends StatelessWidget {
  final double progress;
  final String percentageText;

  const GradientCircularProgress({
    super.key,
    required this.progress,
    required this.percentageText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(220, 220),
            painter: _BackgroundCirclePainter(),
          ),
          CustomPaint(
            size: const Size(220, 220),
            painter: _GradientArcPainter(progress),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Personal\nprogress",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                percentageText,
                style: const TextStyle(
                  color: Color(0xFF9FA8FF),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackgroundCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2 - 14, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _GradientArcPainter extends CustomPainter {
  final double progress;

  _GradientArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: const [Color(0xFF00E5FF), Color(0xFF4A00E0), Color(0xFF8E2DE2)],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2 - 14;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// ======================================================
/// 🧩 COMMON WIDGETS
/// ======================================================

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const _GlassContainer({required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.4),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String title;
  final bool value;

  const _CheckItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (_) {},
          activeColor: Colors.cyanAccent,
        ),
        Expanded(
          child: Text(title, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
