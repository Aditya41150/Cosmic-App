import 'dart:math' as math;
import 'dart:ui';
import 'package:cosmic/features/profile/screens/favourites.dart';
import 'package:cosmic/features/profile/screens/profile_screen.dart';
import 'package:cosmic/features/profile/screens/plant_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Map<String, String>> planets = [
    {"name": "Mercury", "image": "assets/planets/planet1.png", "description": "Mercury is the smallest planet in the Solar System and the closest to the Sun."},
    {"name": "Venus", "image": "assets/planets/planet4.png", "description": "Venus is the second planet from the Sun and is Earth's closest planetary neighbor."},
    {"name": "Earth", "image": "assets/planets/earth.png", "description": "Earth is the third planet from the Sun and the only astronomical object known to harbor life."},
    {"name": "Mars", "image": "assets/planets/planet2.png", "description": "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System."},
    {"name": "Jupiter", "image": "assets/planets/planet5.png", "description": "Jupiter is the fifth planet from the Sun and the largest in the Solar System."},
  ];

  late Map<String, String> _planetOfTheDay;

  @override
  void initState() {
    super.initState();
    _selectPlanetOfTheDay();
  }

  void _selectPlanetOfTheDay() {
    // Select a planet based on the day of the year for a daily rotation
    final now = DateTime.now();
    final dayOfYear = now.day + (now.month * 31); // Simple day identifier
    final index = dayOfYear % planets.length;
    _planetOfTheDay = planets[index];
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. FULL SCREEN BACKDROP (Ignores SafeArea)
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1), duration: 20.seconds),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 120 + bottomPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      /// APP BAR
                      _GlassContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            _CircleButton(
                              icon: Icons.menu,
                              onTap: () {
                                debugPrint("Menu tapped");
                              },
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const Text(
                                  "Milky Way",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Solar System",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.cyanAccent.withValues(alpha: 0.5),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            _CircleButton(
                              icon: Icons.person_outline,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

                      const SizedBox(height: 25),

                      /// SECTION TITLE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Explore Planets",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 15),

                      /// PLANET LIST
                      SizedBox(
                        height: 55,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: planets.length,
                          itemBuilder: (context, index) {
                            final planet = planets[index];
                            return _PlanetChip(
                              name: planet["name"]!,
                              image: planet["image"]!,
                              onTap: () {
                                _navigateToDetails(context, planet);
                              },
                            ).animate(delay: (300 + (index * 100)).ms)
                             .fadeIn()
                             .slideX(begin: 0.2);
                          },
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// PLANET OF THE DAY
                      _GlassContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Planet of the day",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.cyanAccent.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
                                  ),
                                  child: const Text(
                                    "LIVE",
                                    style: TextStyle(color: Colors.cyanAccent, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.cyanAccent.withValues(alpha: 0.2),
                                            blurRadius: 20,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      _planetOfTheDay["image"]!,
                                      width: 75,
                                    ).animate(onPlay: (c) => c.repeat())
                                     .rotate(duration: 15.seconds),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _planetOfTheDay["name"]!,
                                        style: const TextStyle(
                                          color: Colors.cyanAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _planetOfTheDay["description"]!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _navigateToDetails(context, _planetOfTheDay);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text("View Details"),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),

                      const SizedBox(height: 20),

                      /// SOLAR SYSTEM INFO
                      _GlassContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.cyanAccent, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Solar System Info",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              "The Solar System formed 4.6 billion years ago from the gravitational collapse of a giant interstellar molecular cloud. The vast majority of the system's mass is in the Sun.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 800.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. BOTTOM NAV (Positioned relative to physical bottom)
          Positioned(
            bottom: math.max(15, bottomPadding),
            left: 20,
            right: 20,
            child: _GlassContainer(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   _NavButton(
                    icon: Icons.public,
                    label: "Home",
                    active: true,
                    onTap: () {},
                  ),
                  _NavButton(
                    icon: Icons.favorite_border,
                    label: "Favourites",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FavouritesScreen()),
                      );
                    },
                  ),
                  _NavButton(
                    icon: Icons.more_horiz,
                    label: "More",
                    onTap: () {},
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 1.seconds).slideY(begin: 0.5),
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Map<String, String> planet) {
    // Map planets to their specific stats for the details screen
    final stats = {
      "Mercury": {"mass": "0.33", "gravity": "3.7", "day": "1407", "escape": "4.3", "temp": "167", "dist": "57.9", "bg": "assets/backgrounds/mercury_bg.jpg"},
      "Venus": {"mass": "4.87", "gravity": "8.9", "day": "5832", "escape": "10.4", "temp": "464", "dist": "108.2", "bg": "assets/backgrounds/venus_bg.jpg"},
      "Earth": {"mass": "5.97", "gravity": "9.8", "day": "24", "escape": "11.2", "temp": "15", "dist": "149.6", "bg": "assets/backgrounds/earth_bg.jpg"},
      "Mars": {"mass": "0.642", "gravity": "3.7", "day": "24.6", "escape": "5.0", "temp": "-65", "dist": "227.9", "bg": "assets/backgrounds/mars_bg.jpg"},
      "Jupiter": {"mass": "1898", "gravity": "24.8", "day": "9.9", "escape": "59.5", "temp": "-110", "dist": "778.6", "bg": "assets/backgrounds/jupiter_bg.jpg"},
    };

    final pStats = stats[planet["name"]] ?? stats["Mars"]!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanetDetailsScreen(
          name: planet["name"]!,
          imagePath: planet["image"]!,
          backgroundPath: pStats["bg"]!,
          mass: pStats["mass"]!,
          gravity: pStats["gravity"]!,
          day: pStats["day"]!,
          escapeVelocity: pStats["escape"]!,
          meanTemp: pStats["temp"]!,
          distanceFromSun: pStats["dist"]!,
        ),
      ),
    );
  }
}

/// ===================== WIDGETS =====================

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const _GlassContainer({required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.02),
                ],
              ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _PlanetChip extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const _PlanetChip({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image, width: 24)
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: -2, end: 2, duration: 2.seconds),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? Colors.cyanAccent : Colors.white60;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 26)
                .animate(target: active ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
                .shimmer(duration: 1.seconds),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
