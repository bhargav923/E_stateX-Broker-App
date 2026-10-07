// import 'package:app/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/widgets/admin_bottom_navbar.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Profile',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Manage account and system',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileCard(),

            const SizedBox(height: 24),

            _sectionTitle('Account'),

            const SizedBox(height: 10),

            _settingTile(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Manage admin account details',
              onTap: _showPersonalInformation,
            ),

            _settingTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: _showChangePassword,
            ),

            const SizedBox(height: 22),

            _sectionTitle('System'),

            const SizedBox(height: 10),

            _settingTile(
              icon: Icons.report_problem_outlined,
              title: 'Reports & Complaints',
              subtitle: 'View user reports and complaints',
              onTap: _showReports,
            ),

            _settingTile(
              icon: Icons.bar_chart_outlined,
              title: 'Analytics & Statistics',
              subtitle: 'View EstateX platform statistics',
              onTap: _showAnalytics,
            ),

            _switchTile(
              icon: Icons.notifications_none,
              title: 'Notifications',
              subtitle: 'Receive system notifications',
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),

            const SizedBox(height: 22),

            _sectionTitle('Other'),

            const SizedBox(height: 10),

            _settingTile(
              icon: Icons.info_outline,
              title: 'About EstateX',
              subtitle: 'App information and version',
              onTap: _showAbout,
            ),

            _settingTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get help with admin panel',
              onTap: _showSupport,
            ),

            const SizedBox(height: 22),

            _logoutButton(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(),
    );
  }

  Widget _profileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: const Icon(
              Icons.admin_panel_settings_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'EstateX Admin',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'admin@estatex.com',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Administrator',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        leading: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 21),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        leading: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 21),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showPersonalInformation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              _infoRow('Name', 'EstateX Admin'),
              _infoRow('Email', 'admin@estatex.com'),
              _infoRow('Role', 'Administrator'),
              _infoRow('Status', 'Active'),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showChangePassword() {
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Password updated successfully'),
                      ),
                    );
                  },
                  child: const Text('Update Password'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReports() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.80,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reports & Complaints',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'User reports and complaints',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _reportBox(
                        'Open',
                        '12',
                        Icons.report_problem_outlined,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _reportBox(
                        'Resolved',
                        '38',
                        Icons.check_circle_outline,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _reportItem(
                  'Property document issue',
                  'Reported by Rahul Sharma',
                  'Open',
                ),

                _reportItem(
                  'Broker behaviour complaint',
                  'Reported by Priya Patel',
                  'Open',
                ),

                _reportItem(
                  'Incorrect property information',
                  'Reported by Amit Shah',
                  'Resolved',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _reportBox(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reportItem(String title, String subtitle, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.flag_outlined, color: AppColors.error),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: status == 'Open' ? AppColors.warning : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  void _showAnalytics() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.80,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Analytics & Statistics',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'EstateX platform overview',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _analyticsCard('Total Users', '1,248', Icons.people_outline),

                  _analyticsCard('Total Brokers', '186', Icons.badge_outlined),

                  _analyticsCard(
                    'Total Properties',
                    '3,426',
                    Icons.home_work_outlined,
                  ),

                  _analyticsCard('Properties Sold', '824', Icons.sell_outlined),

                  _analyticsCard(
                    'Visits Completed',
                    '2,186',
                    Icons.event_available_outlined,
                  ),

                  _analyticsCard(
                    'Verified Properties',
                    '2,918',
                    Icons.verified_outlined,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _analyticsCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About EstateX'),
          content: const Text('EstateX Admin Panel\n\nVersion 1.0.0'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSupport() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help & Support'),
          content: const Text(
            'For support, contact the EstateX system administrator.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => const LoginPage()),
                MaterialPageRoute(builder: (context) => const Scaffold()),
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
