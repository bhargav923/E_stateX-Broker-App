import 'package:app/utils/routes.dart';
import 'package:app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool changeButton = false;

  String selectedRole = "Buyer";

  final _formkey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final companyController = TextEditingController();
  final experienceController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    companyController.dispose();
    experienceController.dispose();

    super.dispose();
  }

  InputDecoration fieldDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.border, width: 1.2),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  Widget roleButton(String role, IconData icon) {
    final isSelected = selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? AppColors.white : AppColors.textSecondary,
              ),
              const SizedBox(height: 5),
              Text(
                role,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget additionalFields({required ValueKey<String> key}) {
    if (selectedRole == "Buyer") {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        TextFormField(
          controller: companyController,
          decoration: fieldDecoration(
            label: "Agency / Company Name",
            hint: "Enter agency or company name",
            icon: Icons.business_outlined,
          ),
          validator: (value) {
            if (selectedRole == "Broker" &&
                (value == null || value.trim().isEmpty)) {
              return "Please enter agency or company name";
            }

            return null;
          },
        ),

        const SizedBox(height: 22),

        TextFormField(
          controller: experienceController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: fieldDecoration(
            label: "Experience",
            hint: "Years of experience",
            icon: Icons.work_outline,
          ),
          validator: (value) {
            if (selectedRole == "Broker" &&
                (value == null || value.trim().isEmpty)) {
              return "Please enter your experience";
            }

            return null;
          },
        ),

        const SizedBox(height: 18),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Next, you will upload documents and complete the verification payment.",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> registerUser() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    setState(() {
      changeButton = true;
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final fullName = fullNameController.text.trim();
      final phone = phoneController.text.trim();
      final location = locationController.text.trim();
      final isBroker = selectedRole == "Broker";

      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(
          code: "user-not-created",
          message: "Unable to create account.",
        );
      }

      await user.updateDisplayName(fullName);

      final Map<String, dynamic> userData = {
        "uid": user.uid,
        "name": fullName,
        "email": email,
        "phone": phone,
        "location": location,
        "role": selectedRole,
        "createdAt": FieldValue.serverTimestamp(),
      };

      // Extra broker fields
      if (isBroker) {
        userData.addAll({
          "agency": companyController.text.trim(),
          "experience": experienceController.text.trim(),
          "city": location,
          "brokerId": "BRK-${user.uid.substring(0, 5).toUpperCase()}",
          "verification": "Incomplete",
          "account": "Active",
          "paymentStatus": "Unpaid",
          "properties": 0,
          "deals": 0,
          "documents": [],
        });
      }

      await _firestore.collection("users").doc(user.uid).set(userData);

      if (!mounted) return;

      // Broker: login rahega, verification page pe jayega
      if (isBroker) {
        setState(() {
          changeButton = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created. Please complete verification."),
          ),
        );

        Navigator.pushReplacementNamed(
          context,
          MyRoutes.brokerVerificationRoute,
        );

        return;
      }

      // Buyer: pehle jaisa
      await _auth.signOut();

      if (!mounted) return;

      setState(() {
        changeButton = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully. Please login."),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 700));

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "Registration failed.";

      if (e.code == "email-already-in-use") {
        message = "This email is already registered.";
      } else if (e.code == "invalid-email") {
        message = "Please enter a valid email.";
      } else if (e.code == "weak-password") {
        message = "Password is too weak.";
      } else if (e.code == "network-request-failed") {
        message = "Please check your internet connection.";
      } else if (e.message != null && e.message!.isNotEmpty) {
        message = e.message!;
      }

      setState(() {
        changeButton = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;

      setState(() {
        changeButton = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: Image.asset("assets/register.png", fit: BoxFit.cover),
                ),

                const SizedBox(height: 25),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Create your account and start exploring properties.",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Register As",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          roleButton("Buyer", Icons.person_search_outlined),
                          const SizedBox(width: 10),
                          roleButton("Broker", Icons.business_center_outlined),
                        ],
                      ),

                      const SizedBox(height: 28),

                      TextFormField(
                        controller: fullNameController,
                        decoration: fieldDecoration(
                          label: "Full Name",
                          hint: "Enter your full name",
                          icon: Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your name";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: fieldDecoration(
                          label: "Email",
                          hint: "Enter your email",
                          icon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email";
                          }

                          if (!value.contains('@') || !value.contains('.')) {
                            return "Please enter a valid email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: fieldDecoration(
                          label: "Phone Number",
                          hint: "Enter your phone number",
                          icon: Icons.phone_outlined,
                        ).copyWith(counterText: ""),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone number";
                          }

                          if (value.length != 10) {
                            return "Phone number must be 10 digits";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      TextFormField(
                        controller: locationController,
                        decoration: fieldDecoration(
                          label: "Location",
                          hint: "Enter your location",
                          icon: Icons.location_on_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your location";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: additionalFields(key: ValueKey(selectedRole)),
                      ),

                      if (selectedRole == "Broker") const SizedBox(height: 22),

                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordHidden,
                        decoration:
                            fieldDecoration(
                              label: "Password",
                              hint: "Create a password",
                              icon: Icons.lock_outline,
                            ).copyWith(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                                icon: Icon(
                                  isPasswordHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: isConfirmPasswordHidden,
                        decoration:
                            fieldDecoration(
                              label: "Confirm Password",
                              hint: "Re-enter your password",
                              icon: Icons.lock_outline,
                            ).copyWith(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordHidden =
                                        !isConfirmPasswordHidden;
                                  });
                                },
                                icon: Icon(
                                  isConfirmPasswordHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }

                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            changeButton ? 28 : 12,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              changeButton ? 28 : 12,
                            ),
                            splashColor: AppColors.white.withValues(
                              alpha: 0.25,
                            ),
                            onTap: changeButton ? null : registerUser,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              width: changeButton
                                  ? 54
                                  : MediaQuery.of(context).size.width - 56,
                              height: 54,
                              child: changeButton
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Create Account",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, MyRoutes.loginRoute);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
