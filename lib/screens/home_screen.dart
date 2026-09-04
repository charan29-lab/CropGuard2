import 'package:flutter/material.dart';

import '../app/theme.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onScan;

  const HomeScreen({
    super.key,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CropGuard',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good afternoon',
                style: TextStyle(
                  fontSize: 14,
                  color: CropGuardColors.textSecondary,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Keep your crops healthy.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: CropGuardColors.textPrimary,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 28),

              // Main scan section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CropGuardColors.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.center_focus_strong_outlined,
                      color: Colors.white,
                      size: 30,
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Check your crop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Scan a leaf or crop to detect possible diseases and pests.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.82),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onScan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: CropGuardColors.primary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Scan crop',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Field section
              const Text(
                'Your field',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CropGuardColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: CropGuardColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: CropGuardColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: CropGuardColors.secondary.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.grass_outlined,
                        color: CropGuardColors.primary,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Main Field',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rice • Last scan today',
                            style: TextStyle(
                              fontSize: 13,
                              color: CropGuardColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Text(
                      'Healthy',
                      style: TextStyle(
                        color: CropGuardColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Overview
              const Text(
                'Field health',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CropGuardColors.textPrimary,
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _HealthItem(
                      value: '82%',
                      label: 'Healthy',
                      icon: Icons.check_circle_outline,
                      iconColor: CropGuardColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _HealthItem(
                      value: '18%',
                      label: 'Needs attention',
                      icon: Icons.warning_amber_outlined,
                      iconColor: CropGuardColors.warning,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Weather
              const Text(
                'Weather',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CropGuardColors.textPrimary,
                ),
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: CropGuardColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: CropGuardColors.border,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.cloud_outlined,
                      size: 38,
                      color: CropGuardColors.primary,
                    ),

                    SizedBox(width: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '28°C',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Partly cloudy • Humidity 72%',
                          style: TextStyle(
                            fontSize: 13,
                            color: CropGuardColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Recent scans
              const Text(
                'Recent scans',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CropGuardColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              const _RecentScan(
                crop: 'Rice',
                result: 'Healthy',
                date: 'Today',
              ),

              const _RecentScan(
                crop: 'Tomato',
                result: 'Early blight',
                date: 'Yesterday',
                warning: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealthItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;

  const _HealthItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CropGuardColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: CropGuardColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: CropGuardColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentScan extends StatelessWidget {
  final String crop;
  final String result;
  final String date;
  final bool warning;

  const _RecentScan({
    required this.crop,
    required this.result,
    required this.date,
    this.warning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: CropGuardColors.surface,
        border: Border.all(
          color: CropGuardColors.border,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            warning
                ? Icons.warning_amber_outlined
                : Icons.check_circle_outline,
            color: warning
                ? CropGuardColors.warning
                : CropGuardColors.primary,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  result,
                  style: const TextStyle(
                    color: CropGuardColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Text(
            date,
            style: const TextStyle(
              color: CropGuardColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}