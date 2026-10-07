import 'package:flutter/material.dart';

// ==================== Firebase ====================

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

// ==================== Theme ====================

import 'package:app/theme/app_theme.dart';

// ==================== Routes ====================

import 'package:app/utils/routes.dart';

// ==================== Admin ====================

import 'package:app/admin/admin_home_page.dart';
import 'package:app/admin/admin_users_page.dart';
import 'package:app/admin/admin_brokers_page.dart';
import 'package:app/admin/admin_properties_page.dart';
import 'package:app/admin/admin_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

      home: const AuthCheck(),

      routes: {
        // ==================== Admin ====================
        MyRoutes.adminHomeRoute: (context) => const AdminHomePage(),

        MyRoutes.adminUsersRoute: (context) => const AdminUsersPage(),

        MyRoutes.adminBrokersRoute: (context) => const AdminBrokersPage(),

        MyRoutes.adminPropertiesRoute: (context) => const AdminPropertiesPage(),

        MyRoutes.adminProfileRoute: (context) => const AdminProfilePage(),
      },
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<Widget> checkAdmin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const AdminHomePage();
    }

    try {
      final adminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (adminDoc.exists) {
        final data = adminDoc.data();
        final role = data?['role'];

        if (role == 'Admin') {
          return const AdminHomePage();
        }
      }

      return const AdminHomePage();
    } catch (e) {
      return const AdminHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: checkAdmin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return snapshot.data!;
        }

        return const AdminHomePage();
      },
    );
  }
}
