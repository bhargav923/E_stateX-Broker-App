import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/utils/routes.dart';

class BrokerBottomNavbar extends StatelessWidget {
  final int selectedIndex;

  const BrokerBottomNavbar({super.key, required this.selectedIndex});

  final List<Map<String, dynamic>> navItems = const [
    {
      'label': 'Home',
      'icon': Icons.home_outlined,
      'selectedIcon': Icons.home_rounded,
      'route': MyRoutes.brokerHomeRoute,
    },
    {
      'label': 'Properties',
      'icon': Icons.home_work_outlined,
      'selectedIcon': Icons.home_work_rounded,
      'route': MyRoutes.brokerPropertiesRoute,
    },
    {
      'label': 'Visits',
      'icon': Icons.calendar_today_outlined,
      'selectedIcon': Icons.calendar_today_rounded,
      'route': MyRoutes.brokerVisitsRoute,
    },
    {
      'label': 'Buyers',
      'icon': Icons.people_outline_rounded,
      'selectedIcon': Icons.people_rounded,
      'route': MyRoutes.brokerBuyersRoute,
    },
    {
      'label': 'Profile',
      'icon': Icons.account_circle_outlined,
      'selectedIcon': Icons.account_circle_rounded,
      'route': MyRoutes.brokerProfileRoute,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              navItems.length,
              (index) => _buildNavItem(context, index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final bool selected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (selected) {
            return;
          }

          Navigator.pushReplacementNamed(context, navItems[index]['route']);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Icon(
                selected
                    ? navItems[index]['selectedIcon']
                    : navItems[index]['icon'],
                key: ValueKey('${index}_$selected'),
                size: 23,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              navItems[index]['label'],
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
