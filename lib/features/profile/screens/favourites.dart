import 'dart:math' as math;
import 'dart:ui';
import 'package:cosmic/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import './plant_details.dart'; 

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int bottomIndex = 1;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset('assets/background.png', fit: BoxFit.cover)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1), duration: 20.seconds),
          ),

          SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    /// App Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _iconButton(Icons.arrow_back, () => Navigator.pop(context)),
                          const Text(
                            "Favourites",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ).animate().fadeIn(duration: 600.ms),
                          _iconButton(Icons.person_outline, () {}),
                        ],
                      ),
                    ),

                    /// Planet List
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 100 + bottomPadding),
                        children: [
                          const PlanetCard(
                            title: "Mercury",
                            description:
                                "Mercury is the smallest planet in the Solar System and the closest to the Sun.",
                            imagePath: "assets/planets/planet1.png",
                          ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                          const PlanetCard(
                            title: "Venus",
                            description:
                                "Venus is the second planet from the Sun and is Earth's closest planetary neighbor.",
                            imagePath: "assets/planets/planet2.png",
                          ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                          const PlanetCard(
                            title: "Earth",
                            description:
                                "Earth is an ellipsoid with a circumference of about 40,000 km. It is the densest planet in the Solar System.",
                            imagePath: "assets/planets/earth.png",
                          ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                          const PlanetCard(
                            title: "Mars",
                            description:
                                "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System.",
                            imagePath: "assets/planets/planet4.png",
                          ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          /// Floating Nav
          Positioned(
            bottom: math.max(15, bottomPadding),
            left: 20,
            right: 20,
            child: Center(
               child: ConstrainedBox(
                 constraints: const BoxConstraints(maxWidth: 600),
                 child: _bottomNav(),
               ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).scale();
  }

  Widget _bottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navIcon(Icons.public, 0, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }),
                _navIcon(Icons.favorite, 1, () {}),
                _navIcon(Icons.more_horiz, 2, () {}),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.5);
  }

  Widget _navIcon(IconData icon, int index, VoidCallback onTap) {
    final bool selected = bottomIndex == index;
    return IconButton(
      onPressed: onTap,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selected ? const Color(0xFF00E5FF) : Colors.white54,
            size: 26,
          ).animate(target: selected ? 1 : 0).scale(begin: const Offset(1,1), end: const Offset(1.2, 1.2)),
        ],
      ),
    );
  }
}

/// ================= PLANET CARD =================

class PlanetCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const PlanetCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  State<PlanetCard> createState() => _PlanetCardState();
}

class _PlanetCardState extends State<PlanetCard> {
  bool isFav = false;

  void _openDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          switch (widget.title) {
            case "Mercury":
              return const PlanetDetailsScreen(
                name: "Mercury",
                imagePath: "assets/planets/planet1.png",
                backgroundPath: "assets/backgrounds/mercury_bg.jpg",
                mass: "0.33",
                gravity: "3.7",
                day: "1407",
                escapeVelocity: "4.3",
                meanTemp: "167",
                distanceFromSun: "57.9",
              );

            case "Venus":
              return const PlanetDetailsScreen(
                name: "Venus",
                imagePath: "assets/planets/planet2.png",
                backgroundPath: "assets/backgrounds/venus_bg.jpg",
                mass: "4.87",
                gravity: "8.9",
                day: "5832",
                escapeVelocity: "10.4",
                meanTemp: "464",
                distanceFromSun: "108.2",
              );

            case "Earth":
              return const PlanetDetailsScreen(
                name: "Earth",
                imagePath: "assets/planets/earth.png",
                backgroundPath: "assets/backgrounds/earth_bg.jpg",
                mass: "5.97",
                gravity: "9.8",
                day: "24",
                escapeVelocity: "11.2",
                meanTemp: "15",
                distanceFromSun: "149.6",
              );

            case "Mars":
              return const PlanetDetailsScreen(
                name: "Mars",
                imagePath: "assets/planets/planet4.png",
                backgroundPath: "assets/backgrounds/mars_bg.jpg",
                mass: "0.642",
                gravity: "3.7",
                day: "24.6",
                escapeVelocity: "5.0",
                meanTemp: "-65",
                distanceFromSun: "227.9",
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _openDetails(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Planet Image
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.6),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),

                  /// Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00E5FF),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Color(0xFF00E5FF),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Favourite Button
                  IconButton(
                    onPressed: () {
                      setState(() => isFav = !isFav);
                    },
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
