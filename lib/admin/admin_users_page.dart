import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/widgets/admin_bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController searchController = TextEditingController();

  String selectedFilter = 'All';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  StreamSubscription<QuerySnapshot>? _usersSubscription;

  @override
  void initState() {
    super.initState();
    _setupUsersListener();
  }

  void _setupUsersListener() {
    setState(() {
      isLoading = true;
    });

    _usersSubscription = _firestore
        .collection('users')
        .snapshots(includeMetadataChanges: false)
        .listen(
          (snapshot) {
            if (mounted) {
              // Always replace the entire list with the latest data from Firestore
              setState(() {
                users = snapshot.docs
                    .map((doc) {
                      final data = doc.data();
                      final createdAt = data['createdAt'] as Timestamp?;

                      // Format date from Timestamp
                      String joinedDate = 'N/A';
                      if (createdAt != null) {
                        final date = createdAt.toDate();
                        joinedDate =
                            '${date.day} ${_getMonthName(date.month)} ${date.year}';
                      }

                      return {
                        'uid': data['uid'] ?? doc.id,
                        'name': data['name'] ?? 'Unknown',
                        'email': data['email'] ?? 'No email',
                        'phone': data['phone'] ?? 'No phone',
                        'location': data['location'] ?? 'Unknown',
                        'status': data['status'] ?? 'Active',
                        'role': data['role'] ?? 'Buyer',
                        'joined': joinedDate,
                        'city': data['location'] ?? 'Unknown',
                        'propertiesBought': data['propertiesBought'] ?? 0,
                        'propertiesViewed': data['propertiesViewed'] ?? 0,
                        'visitsBooked': data['visitsBooked'] ?? 0,
                        'completedVisits': data['completedVisits'] ?? 0,
                        'wishlist': data['wishlist'] ?? 0,
                        'cancelledVisits': data['cancelledVisits'] ?? 0,
                        'totalSpent': data['totalSpent'] ?? '₹0',
                        'activeBookings': data['activeBookings'] ?? 0,
                        'profileVerified': data['profileVerified'] ?? true,
                        'purchasedProperties':
                            data['purchasedProperties'] ?? [],
                        'recentVisits': data['recentVisits'] ?? [],
                      };
                    })
                    .where((user) => user['role'] == 'Buyer')
                    .toList();
                isLoading = false;
              });
            }
          },
          onError: (e) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error loading users: $e'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        );
  }

  Future<void> _refreshUsers() async {
    _usersSubscription?.cancel();
    users.clear();
    setState(() {
      isLoading = true;
    });
    _setupUsersListener();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  List<Map<String, dynamic>> get filteredUsers {
    String search = searchController.text.toLowerCase();

    return users.where((user) {
      bool matchesSearch =
          user['name'].toString().toLowerCase().contains(search) ||
          user['email'].toString().toLowerCase().contains(search) ||
          user['location'].toString().toLowerCase().contains(search);

      bool matchesFilter =
          selectedFilter == 'All' || user['status'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    _usersSubscription?.cancel();
    super.dispose();
  }

  void showUserDetails(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _userHeader(user),
                      const SizedBox(height: 22),

                      _sectionTitle('Purchase Summary'),
                      const SizedBox(height: 10),
                      _summaryGrid(user),

                      const SizedBox(height: 22),

                      _sectionTitle('User Activity'),
                      const SizedBox(height: 10),
                      _activityCard(user),

                      const SizedBox(height: 22),

                      _sectionTitle('Purchased Properties'),
                      const SizedBox(height: 10),
                      _purchasedProperties(user),

                      const SizedBox(height: 22),

                      _sectionTitle('Recent Visits'),
                      const SizedBox(height: 10),
                      _recentVisits(user),

                      const SizedBox(height: 22),

                      _sectionTitle('Account Information'),
                      const SizedBox(height: 10),
                      _accountInformation(user),

                      const SizedBox(height: 22),

                      _sectionTitle('Account Control'),
                      const SizedBox(height: 10),
                      _accountControl(user),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userHeader(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Text(
              user['name'][0],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user['email'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  user['phone'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          _statusBadge(user['status']),
        ],
      ),
    );
  }

  Widget _summaryGrid(Map<String, dynamic> user) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.1,
      children: [
        _smallInfoCard(
          'Properties Bought',
          '${user['propertiesBought']}',
          Icons.home_work_outlined,
        ),
        _smallInfoCard('Total Spent', user['totalSpent'], Icons.currency_rupee),
        _smallInfoCard(
          'Active Bookings',
          '${user['activeBookings']}',
          Icons.event_available_outlined,
        ),
        _smallInfoCard(
          'Completed Visits',
          '${user['completedVisits']}',
          Icons.check_circle_outline,
        ),
      ],
    );
  }

  Widget _smallInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 19, color: AppColors.primary),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityCard(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _activityRow(
            'Properties Viewed',
            '${user['propertiesViewed']}',
            Icons.visibility_outlined,
          ),
          _divider(),
          _activityRow(
            'Visits Booked',
            '${user['visitsBooked']}',
            Icons.calendar_month_outlined,
          ),
          _divider(),
          _activityRow(
            'Wishlist Properties',
            '${user['wishlist']}',
            Icons.favorite_border,
          ),
          _divider(),
          _activityRow(
            'Cancelled Visits',
            '${user['cancelledVisits']}',
            Icons.event_busy_outlined,
          ),
        ],
      ),
    );
  }

  Widget _activityRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _purchasedProperties(Map<String, dynamic> user) {
    List properties = user['purchasedProperties'];

    if (properties.isEmpty) {
      return _emptyBox('No property purchased yet.');
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: properties.map<Widget>((property) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.home_work_outlined,
                    size: 20,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    property,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _recentVisits(Map<String, dynamic> user) {
    List visits = user['recentVisits'];

    if (visits.isEmpty) {
      return _emptyBox('No visits found.');
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: visits.map<Widget>((property) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: const Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
            ),
            title: Text(
              property,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: const Text(
              'Property visit',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _accountInformation(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _detailRow('Location', user['location']),
          _divider(),
          _detailRow('Joined', user['joined']),
          _divider(),
          _detailRow(
            'Profile Verified',
            user['profileVerified'] ? 'Yes' : 'No',
          ),
          _divider(),
          _detailRow('Account Status', user['status']),
        ],
      ),
    );
  }

  Widget _accountControl(Map<String, dynamic> user) {
    bool isBlocked = user['status'] == 'Blocked';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                final newStatus = isBlocked ? 'Active' : 'Blocked';

                try {
                  await _firestore.collection('users').doc(user['uid']).update({
                    'status': newStatus,
                  });

                  if (mounted) {
                    setState(() {
                      user['status'] = newStatus;
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isBlocked
                              ? 'User unblocked successfully'
                              : 'User blocked successfully',
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to update user status'),
                      ),
                    );
                  }
                }
              },
              icon: Icon(
                isBlocked ? Icons.lock_open_outlined : Icons.block_outlined,
              ),
              label: Text(isBlocked ? 'Unblock User' : 'Block User'),
              style: OutlinedButton.styleFrom(
                foregroundColor: isBlocked
                    ? AppColors.success
                    : AppColors.error,
                side: BorderSide(
                  color: isBlocked ? AppColors.success : AppColors.error,
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _removeUser(user);
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text('Remove'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeUser(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove User'),
          content: Text('Are you sure you want to remove ${user['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firestore
                      .collection('users')
                      .doc(user['uid'])
                      .delete();

                  if (mounted) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('User removed successfully'),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Failed to remove user')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String title, String value) {
    return Row(
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
    );
  }

  Widget _divider() {
    return const Divider(height: 20, color: AppColors.divider);
  }

  Widget _emptyBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
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

  Widget _statusBadge(String status) {
    Color color;

    if (status == 'Active') {
      color = AppColors.success;
    } else if (status == 'Blocked') {
      color = AppColors.error;
    } else {
      color = AppColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _userCard(Map<String, dynamic> user) {
    return InkWell(
      onTap: () => showUserDetails(user),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primary.withValues(alpha: 0.10),
              child: Text(
                user['name'][0],
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user['email'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        user['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.home_work_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${user['propertiesBought']} Bought',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                _statusBadge(user['status']),
                const SizedBox(height: 8),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String title) {
    bool selected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUsers = filteredUsers;

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
              'Users',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Manage platform users',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _refreshUsers,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 12),
                  child: TextField(
                    controller: searchController,
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search user, email or location',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close),
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.surface,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _filterChip('All'),
                      const SizedBox(width: 8),
                      _filterChip('Active'),
                      const SizedBox(width: 8),
                      _filterChip('Inactive'),
                      const SizedBox(width: 8),
                      _filterChip('Blocked'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: currentUsers.isEmpty
                      ? _emptyBox('No users found.')
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          itemCount: currentUsers.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return _userCard(currentUsers[index]);
                          },
                        ),
                ),
              ],
            ),
      bottomNavigationBar: const AdminBottomNavbar(),
    );
  }
}
