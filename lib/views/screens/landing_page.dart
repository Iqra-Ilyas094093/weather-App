import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF137FEC),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF137FEC),
          brightness: Brightness.dark,
        ),
      ),
      home: const WeatherLandingPage(),
    );
  }
}

class WeatherLandingPage extends StatelessWidget {
  const WeatherLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade900,
              Colors.blueGrey.shade900,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background image with opacity
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAQZh1YI9RkwoGZhdeFGUHoSiSjt-WfRAI3JPNvbqGFe5FMogvza64ZX7X13f32lxRGRI66HKSRvbY3ALdfJzoeAmOyMiC3d01s4W6mxHshphVad5cynfseaXpzPVIh0QGgj_78IQrF43p0JVB6pBK3RzcOBbzlaZAO5npw7SN1wog8KjD0JdUHVrr-KdVmRpXx7_1LW57d62_OGnKBGP5zlSUULJz9jdlNx44ShjsGfnS1z2W1FVAKfz12Vc9W7H1lUjbgYYwBDu8',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud,
                          color: Color(0xFF137FEC),
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Weatherly',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // Title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Your Weather, Instantly and Accurately',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Feature grid
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: const [
                                FeatureCard(
                                  icon: Icons.location_on,
                                  title: 'Hyper-local forecasts',
                                  description: 'Get precise weather for your exact location.',
                                ),
                                FeatureCard(
                                  icon: Icons.notifications_active,
                                  title: 'Customizable alerts',
                                  description: 'Set up notifications for severe weather.',
                                ),
                                FeatureCard(
                                  icon: Icons.map,
                                  title: 'Interactive radar maps',
                                  description: 'Track storms with our advanced maps.',
                                ),
                                FeatureCard(
                                  icon: Icons.explore,
                                  title: 'Global coverage',
                                  description: 'Access weather for any location on Earth.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Footer buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF137FEC),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Create Free Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Already have an account? Log In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF324D67).withOpacity(0.5)),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF137FEC),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Manrope',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: const Color(0xFF92ADC9),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      ),
    );
  }
}