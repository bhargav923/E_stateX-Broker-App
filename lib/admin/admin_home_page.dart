import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/widgets/admin_bottom_navbar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.admin_panel_settings_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EstateX',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textPrimary,
              size: 27,
            ),
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
                'Dashboard',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Manage and monitor your EstateX platform',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.people_alt_outlined,
                      title: 'Buyers',
                      value: '1,248',
                      iconColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statCard(
                      icon: Icons.business_center_outlined,
                      title: 'Brokers',
                      value: '186',
                      iconColor: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.home_work_outlined,
                      title: 'Properties',
                      value: '3,426',
                      iconColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statCard(
                      icon: Icons.verified_outlined,
                      title: 'Verified',
                      value: '2,918',
                      iconColor: AppColors.success,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                'Quick Overview',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),

              _overviewCard(
                icon: Icons.pending_actions_rounded,
                title: 'Pending Verification',
                subtitle: 'Properties waiting for verification',
                value: '508',
                color: AppColors.warning,
              ),
              const SizedBox(height: 10),
              _overviewCard(
                icon: Icons.report_problem_outlined,
                title: 'Open Reports',
                subtitle: 'Reports and complaints to review',
                value: '24',
                color: AppColors.error,
              ),
              const SizedBox(height: 10),
              _overviewCard(
                icon: Icons.person_off_outlined,
                title: 'Inactive Accounts',
                subtitle: 'Users currently inactive',
                value: '37',
                color: AppColors.textSecondary,
              ),

              const SizedBox(height: 28),

              const Text(
                'Recent Activity',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),

              _activityTile(
                icon: Icons.home_work_rounded,
                title: 'New property listed',
                subtitle: 'Property #EX1024 was added',
                time: '10 min ago',
              ),
              _activityTile(
                icon: Icons.person_add_alt_1_rounded,
                title: 'New broker registered',
                subtitle: 'A new broker joined EstateX',
                time: '32 min ago',
              ),
              _activityTile(
                icon: Icons.verified_rounded,
                title: 'Property verified',
                subtitle: 'Property #EX1018 was verified',
                time: '1 hour ago',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: color, size: 23),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
