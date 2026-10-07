import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/utils/routes.dart';

class AdminBottomNavbar extends StatefulWidget {
  const AdminBottomNavbar({super.key});

  @override
  State<AdminBottomNavbar> createState() => _AdminBottomNavbarState();
}

class _AdminBottomNavbarState extends State<AdminBottomNavbar> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> navItems = [
    {
      'label': 'Dashboard',
      'icon': Icons.dashboard_outlined,
      'activeIcon': Icons.dashboard_rounded,
      'route': MyRoutes.adminHomeRoute,
    },
    {
      'label': 'Users',
      'icon': Icons.people_outline_rounded,
      'activeIcon': Icons.people_rounded,
      'route': MyRoutes.adminUsersRoute,
    },
    {
      'label': 'Brokers',
      'icon': Icons.business_center_outlined,
      'activeIcon': Icons.business_center_rounded,
      'route': MyRoutes.adminBrokersRoute,
    },
    {
      'label': 'Properties',
      'icon': Icons.home_work_outlined,
      'activeIcon': Icons.home_work_rounded,
      'route': MyRoutes.adminPropertiesRoute,
    },
    {
      'label': 'Profile',
      'icon': Icons.person_outline_rounded,
      'activeIcon': Icons.person_rounded,
      'route': MyRoutes.adminProfileRoute,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentRoute = ModalRoute.of(context)?.settings.name;

    final index = navItems.indexWhere(
      (item) => item['route'] == currentRoute,
    );

    if (index != -1 && index != selectedIndex) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  void _changePage(int index) {
    if (index == selectedIndex) return;

    setState(() {
      selectedIndex = index;
    });

    Navigator.pushReplacementNamed(
      context,
      navItems[index]['route'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          navItems.length,
          (index) {
            final isSelected = selectedIndex == index;
            final item = navItems[index];

            return Expanded(
              child: GestureDetector(
                onTap: () => _changePage(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.10)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isSelected
                              ? item['activeIcon']
                              : item['icon'],
                          key: ValueKey(isSelected),
                          size: 24,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        child: Text(
                          item['label'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

