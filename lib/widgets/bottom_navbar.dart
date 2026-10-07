import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/utils/routes.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<Map<String, dynamic>> navItems = [
    {
      'label': 'Home',
      'icon': Icons.home_outlined,
      'selectedIcon': Icons.home_rounded,
      'route': MyRoutes.buyerHomeRoute,
    },
    {
      'label': 'Search',
      'icon': Icons.search_outlined,
      'selectedIcon': Icons.search_rounded,
      'route': MyRoutes.searchRoute,
    },
    {
      'label': 'Wishlist',
      'icon': Icons.favorite_border_rounded,
      'selectedIcon': Icons.favorite_rounded,
      'route': MyRoutes.wishlistRoute,
    },
    {
      'label': 'Visits',
      'icon': Icons.shopping_bag_outlined,
      'selectedIcon': Icons.shopping_bag_rounded,
      'route': MyRoutes.visitsRoute,
    },
    {
      'label': 'Profile',
      'icon': Icons.account_circle_outlined,
      'selectedIcon': Icons.account_circle_rounded,
      'route': MyRoutes.profileRoute,
    },
  ];

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    int selectedIndex = navItems.indexWhere(
      (item) => item['route'] == currentRoute,
    );

    if (selectedIndex == -1) {
      selectedIndex = 0;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 76,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              navItems.length,
              (index) => _buildNavItem(context, index, selectedIndex),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, int selectedIndex) {
    final bool selected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (selected) return;

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              settings: RouteSettings(name: navItems[index]['route'] as String),
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 180),
              pageBuilder: (context, animation, secondaryAnimation) {
                // return _getPage(index);
                return const SizedBox();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final animationCurve = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    );

                    return FadeTransition(
                      opacity: animationCurve,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.985,
                          end: 1.0,
                        ).animate(animationCurve),
                        child: child,
                      ),
                    );
                  },
            ),
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Icon(
                selected
                    ? navItems[index]['selectedIcon']
                    : navItems[index]['icon'],
                key: ValueKey('${index}_$selected'),
                size: 28,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              navItems[index]['label'],
              style: TextStyle(
                fontSize: 12,
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
