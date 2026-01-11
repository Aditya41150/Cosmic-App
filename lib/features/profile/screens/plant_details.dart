import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlanetDetailsScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String backgroundPath;

  final String mass;
  final String gravity;
  final String day;
  final String escapeVelocity;
  final String meanTemp;
  final String distanceFromSun;

  const PlanetDetailsScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.backgroundPath,
    required this.mass,
    required this.gravity,
    required this.day,
    required this.escapeVelocity,
    required this.meanTemp,
    required this.distanceFromSun,
  });

  @override
  State<PlanetDetailsScreen> createState() => _PlanetDetailsScreenState();
}

class _PlanetDetailsScreenState extends State<PlanetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. FULL SCREEN BACKDROP
          Positioned.fill(
            child: Image.asset(
              "assets/background.png",
              fit: BoxFit.cover,
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 15.seconds),
          ),

          // 2. DARK OVERLAY
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.35)),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30 + bottomPadding),
                  child: Column(
                    children: [
                      /// Top Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _circleButton(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.pop(context),
                            ),
                            _circleButton(icon: Icons.favorite_border, onTap: () {}),
                          ],
                        ),
                      ).animate().fadeIn().slideY(begin: -0.2),

                      const SizedBox(height: 20),

                      /// 🔄 ROTATING PLANET
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent.withValues(alpha: 0.3),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          Image.asset(widget.imagePath, width: 170, fit: BoxFit.cover)
                              .animate(onPlay: (c) => c.repeat())
                              .rotate(duration: 20.seconds),
                        ],
                      ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.5, 0.5)),

                      const SizedBox(height: 20),

                      /// Planet Name
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 200.ms).shimmer(duration: 2.seconds),

                      const SizedBox(height: 30),

                      /// Stats Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GridView.count(
                          crossAxisCount: MediaQuery.of(context).size.width < 360 ? 2 : 3,
                          mainAxisSpacing: 28,
                          crossAxisSpacing: 16,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _statItem(Icons.account_balance, "Mass\n(10²⁴ kg)", widget.mass, 300.ms),
                            _statItem(Icons.public, "Gravity\n(m/s²)", widget.gravity, 400.ms),
                            _statItem(Icons.wb_sunny, "Day\n(hours)", widget.day, 500.ms),
                            _statItem(Icons.rocket_launch, "Esc. Velocity\n(km/s)", widget.escapeVelocity, 600.ms),
                            _statItem(Icons.thermostat, "Mean Temp\n(°C)", widget.meanTemp, 700.ms),
                            _statItem(Icons.straighten, "Distance\n(10⁶ km)", widget.distanceFromSun, 800.ms),
                          ],
                        ),
                      ),
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

  /// Glass icon button
  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }

  /// Stat item with animation
  Widget _statItem(IconData icon, String title, String value, Duration delay) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            height: 1.2,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(delay: delay).slideY(begin: 0.2);
  }
}
