import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/widgets/admin_bottom_navbar.dart';

class AdminBrokersPage extends StatefulWidget {
  const AdminBrokersPage({super.key});

  @override
  State<AdminBrokersPage> createState() => _AdminBrokersPageState();
}

class _AdminBrokersPageState extends State<AdminBrokersPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String selectedFilter = 'All';

  // Firebase se saare brokers (live)
  final Stream<QuerySnapshot<Map<String, dynamic>>> _brokersStream =
      FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Broker')
          .snapshots();

  @override
  void dispose() {
    searchController.dispose();
    noteController.dispose();
    super.dispose();
  }

  // ==================== FIREBASE ====================

  String _formatDate(dynamic value) {
    if (value is Timestamp) {
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

      final date = value.toDate();
      final day = date.day.toString().padLeft(2, '0');

      return '$day ${months[date.month - 1]} ${date.year}';
    }

    return '-';
  }

  Map<String, dynamic> _brokerFromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    final rawName = (data['name'] ?? '').toString().trim();
    final rawExperience = (data['experience'] ?? '').toString().trim();
    final rawDocuments = (data['documents'] as List?) ?? [];

    final createdAt = data['createdAt'];

    return {
      'uid': doc.id,
      'name': rawName.isEmpty ? 'Broker' : rawName,
      'email': (data['email'] ?? '-').toString(),
      'phone': (data['phone'] ?? '-').toString(),
      'city': (data['city'] ?? data['location'] ?? '-').toString(),
      'license': (data['brokerId'] ?? '-').toString(),
      'agency': (data['agency'] ?? '-').toString(),
      'office': (data['location'] ?? '-').toString(),
      'experience': RegExp(r'^\d+$').hasMatch(rawExperience)
          ? '$rawExperience Years'
          : (rawExperience.isEmpty ? '-' : rawExperience),
      'properties': data['properties'] ?? 0,
      'deals': data['deals'] ?? 0,
      'joined': _formatDate(createdAt),
      'createdMs': createdAt is Timestamp
          ? createdAt.millisecondsSinceEpoch
          : 0,
      'account': (data['account'] ?? 'Active').toString(),
      'verification': (data['verification'] ?? 'Needs Review').toString(),
      'adminNote': (data['adminNote'] ?? '').toString(),
      'documents': rawDocuments
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    };
  }

  Future<void> _updateBroker(
    Map<String, dynamic> broker,
    Map<String, dynamic> data,
    String successMessage,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(broker['uid'])
          .update(data);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(successMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to update. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  List<Map<String, dynamic>> _filterBrokers(List<Map<String, dynamic>> all) {
    final query = searchController.text.trim().toLowerCase();

    return all.where((broker) {
      final matchesSearch =
          broker['name'].toString().toLowerCase().contains(query) ||
          broker['email'].toString().toLowerCase().contains(query) ||
          broker['city'].toString().toLowerCase().contains(query) ||
          broker['license'].toString().toLowerCase().contains(query) ||
          broker['agency'].toString().toLowerCase().contains(query);

      final matchesFilter =
          selectedFilter == 'All' ||
          broker['verification'].toString() == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Color _verificationColor(String status) {
    switch (status) {
      case 'Approved':
        return AppColors.success;
      case 'Rejected':
        return AppColors.error;
      case 'Changes Requested':
        return AppColors.primary;
      default:
        return AppColors.warning;
    }
  }

  Color _documentColor(String status) {
    switch (status) {
      case 'Verified':
        return AppColors.success;
      case 'Rejected':
        return AppColors.error;
      case 'Needs Update':
        return AppColors.primary;
      case 'Uploaded':
        return AppColors.primary;
      case 'Missing':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  Color _accountColor(String status) {
    switch (status) {
      case 'Active':
        return AppColors.success;
      case 'Blocked':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  void _showBrokerDetails(Map<String, dynamic> broker) {
    noteController.text = broker['adminNote'] ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.93,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 15),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        broker['name'].toString().substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            broker['name'],
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            broker['license'],
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _statusBadge(
                      broker['verification'],
                      _verificationColor(broker['verification']),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Broker Overview', Icons.badge_outlined),
                        const SizedBox(height: 10),
                        _overviewCard(broker),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Professional Details',
                          Icons.business_center_outlined,
                        ),
                        const SizedBox(height: 10),
                        _professionalCard(broker),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Verification Documents',
                          Icons.folder_open_outlined,
                        ),
                        const SizedBox(height: 5),
                        _documentProgress(broker),
                        const SizedBox(height: 10),
                        ...List.generate(broker['documents'].length, (index) {
                          return _documentCard(broker['documents'][index]);
                        }),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Verification Checklist',
                          Icons.checklist_rounded,
                        ),
                        const SizedBox(height: 10),
                        _checklistItem(
                          'Broker license verified',
                          _hasVerifiedDocument(
                            broker,
                            'Broker Registration / License',
                          ),
                        ),
                        _checklistItem(
                          'Identity verified',
                          _hasVerifiedDocument(broker, 'Government ID Proof'),
                        ),
                        _checklistItem(
                          'Address verified',
                          _hasVerifiedDocument(broker, 'Address Proof'),
                        ),
                        _checklistItem(
                          'Business details verified',
                          _hasVerifiedDocument(
                            broker,
                            'Business / Agency Proof',
                          ),
                        ),
                        _checklistItem(
                          'Office address verified',
                          _hasVerifiedDocument(broker, 'Office Address Proof'),
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Admin Verification Note',
                          Icons.edit_note_rounded,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: noteController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Add verification note...',
                            hintStyle: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                            filled: true,
                            fillColor: AppColors.background,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Account Control',
                          Icons.admin_panel_settings_outlined,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _toggleAccountStatus(broker);
                            },
                            icon: Icon(
                              broker['account'] == 'Blocked'
                                  ? Icons.lock_open_outlined
                                  : Icons.block_outlined,
                            ),
                            label: Text(
                              broker['account'] == 'Blocked'
                                  ? 'Unblock Broker'
                                  : 'Block Broker',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: broker['account'] == 'Blocked'
                                  ? AppColors.success
                                  : AppColors.error,
                              side: BorderSide(
                                color: broker['account'] == 'Blocked'
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _verificationActions(broker),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _hasVerifiedDocument(Map<String, dynamic> broker, String documentName) {
    for (final document in broker['documents']) {
      if (document['name'] == documentName &&
          document['status'] == 'Verified') {
        return true;
      }
    }

    return false;
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 19),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _overviewCard(Map<String, dynamic> broker) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _detailRow(Icons.email_outlined, 'Email', broker['email']),
          _detailRow(Icons.phone_outlined, 'Phone', broker['phone']),
          _detailRow(Icons.location_on_outlined, 'City', broker['city']),
          _detailRow(Icons.badge_outlined, 'Broker ID', broker['license']),
          _detailRow(Icons.calendar_today_outlined, 'Joined', broker['joined']),
        ],
      ),
    );
  }

  Widget _professionalCard(Map<String, dynamic> broker) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _detailRow(Icons.business_outlined, 'Agency', broker['agency']),
          _detailRow(Icons.location_city_outlined, 'Office', broker['office']),
          _detailRow(
            Icons.workspace_premium_outlined,
            'Experience',
            broker['experience'],
          ),
          _detailRow(
            Icons.home_work_outlined,
            'Properties',
            '${broker['properties']}',
          ),
          _detailRow(
            Icons.handshake_outlined,
            'Completed Deals',
            '${broker['deals']}',
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 9),
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentProgress(Map<String, dynamic> broker) {
    final documents = broker['documents'] as List;
    final verified = documents
        .where((document) => document['status'] == 'Verified')
        .length;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Document Verification',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '$verified/${documents.length} Verified',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: documents.isEmpty ? 0 : verified / documents.length,
              minHeight: 6,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentCard(Map<String, dynamic> document) {
    final color = _documentColor(document['status']);

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppColors.primary,
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document['name'],
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  document['file'] == '-'
                      ? 'Document not uploaded'
                      : '${document['file']} • ${document['date']}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 5),
                _statusBadge(document['status'], color),
              ],
            ),
          ),
          if (document['file'] != '-')
            TextButton(
              onPressed: () {
                _showDocumentPreview(document);
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ),
        ],
      ),
    );
  }

  void _showDocumentPreview(Map<String, dynamic> document) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.description_outlined, color: AppColors.primary),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  document['name'],
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf_outlined,
                      color: AppColors.error,
                      size: 48,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      document['file'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Document Preview',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Document Status',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(),
                  _statusBadge(
                    document['status'],
                    _documentColor(document['status']),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _checklistItem(String title, bool completed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: completed
            ? AppColors.success.withValues(alpha: 0.06)
            : AppColors.warning.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: completed
              ? AppColors.success.withValues(alpha: 0.18)
              : AppColors.warning.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: completed ? AppColors.success : AppColors.warning,
            size: 19,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: completed
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            completed ? 'Complete' : 'Pending',
            style: TextStyle(
              color: completed ? AppColors.success : AppColors.warning,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verificationActions(Map<String, dynamic> broker) {
    final status = broker['verification'].toString();

    // Approved ya Rejected ke baad action buttons nahi dikhenge
    if (status == 'Approved' || status == 'Rejected') {
      final isApproved = status == 'Approved';
      final color = isApproved ? AppColors.success : AppColors.error;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isApproved ? Icons.verified_rounded : Icons.cancel_rounded,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              isApproved ? 'Broker already approved' : 'Broker rejected',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    // Correction pehle hi maangi ja chuki hai to wo button chhupao
    final showCorrection = status != 'Changes Requested';

    return Row(
      children: [
        if (showCorrection) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                _requestCorrection(broker);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text(
                'Request Correction',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _approveBroker(broker);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text(
              'Approve Broker',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _rejectBroker(broker);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text(
              'Reject Broker',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== ADMIN ACTIONS (Firebase) ====================

  Future<void> _approveBroker(Map<String, dynamic> broker) async {
    final documents = (broker['documents'] as List).map((item) {
      final document = Map<String, dynamic>.from(item as Map);

      if (document['status'] == 'Uploaded' || document['status'] == 'Pending') {
        document['status'] = 'Verified';
      }

      return document;
    }).toList();

    await _updateBroker(broker, {
      'verification': 'Approved',
      'documents': documents,
      'adminNote': noteController.text.trim(),
    }, 'Broker approved successfully');
  }

  Future<void> _requestCorrection(Map<String, dynamic> broker) async {
    await _updateBroker(broker, {
      'verification': 'Changes Requested',
      'adminNote': noteController.text.trim(),
    }, 'Correction request sent to broker');
  }

  Future<void> _rejectBroker(Map<String, dynamic> broker) async {
    await _updateBroker(broker, {
      'verification': 'Rejected',
      'account': 'Blocked',
      'adminNote': noteController.text.trim(),
    }, 'Broker rejected');
  }

  Future<void> _toggleAccountStatus(Map<String, dynamic> broker) async {
    final newStatus = broker['account'] == 'Blocked' ? 'Active' : 'Blocked';

    await _updateBroker(broker, {
      'account': newStatus,
    }, newStatus == 'Blocked' ? 'Broker blocked' : 'Broker unblocked');
  }

  Widget _statusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String filter) {
    final isSelected = selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _pendingReviewBox(Map<String, dynamic> broker) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.fact_check_outlined,
              color: AppColors.warning,
              size: 18,
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification Required',
                  style: TextStyle(
                    color: AppColors.warning,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Broker documents need review',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 9),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showBrokerDetails(broker);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Review',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _brokerCard(Map<String, dynamic> broker) {
    final verificationColor = _verificationColor(broker['verification']);

    final accountColor = _accountColor(broker['account']);

    final needsReview =
        broker['verification'] == 'Needs Review' ||
        broker['verification'] == 'Changes Requested';

    return GestureDetector(
      onTap: () {
        _showBrokerDetails(broker);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: needsReview
                ? AppColors.warning.withValues(alpha: 0.45)
                : AppColors.border,
            width: needsReview ? 1.2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.09),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    broker['name'].toString().substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        broker['name'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            broker['city'],
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.badge_outlined,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            broker['license'],
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 13),
            Container(height: 1, color: AppColors.divider),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _cardInfo(
                    Icons.home_work_outlined,
                    '${broker['properties']}',
                    'Properties',
                  ),
                ),
                Expanded(
                  child: _cardInfo(
                    Icons.handshake_outlined,
                    '${broker['deals']}',
                    'Deals',
                  ),
                ),
                Expanded(
                  child: _cardInfo(
                    Icons.workspace_premium_outlined,
                    broker['experience'],
                    'Experience',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _statusBadge(broker['verification'], verificationColor),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: accountColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      broker['account'],
                      style: TextStyle(
                        color: accountColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (needsReview) _pendingReviewBox(broker),
          ],
        ),
      ),
    );
  }

  Widget _cardInfo(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 17),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Brokers',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Manage brokers and verify documents',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _brokersStream,
          builder: (context, snapshot) {
            // Jinhone abhi registration poora nahi kiya (Incomplete) wo nahi dikhenge
            final allBrokers = snapshot.hasData
                ? (snapshot.data!.docs
                      .map(_brokerFromDoc)
                      .where((broker) => broker['verification'] != 'Incomplete')
                      .toList()
                    ..sort(
                      (a, b) => (b['createdMs'] as int).compareTo(
                        a['createdMs'] as int,
                      ),
                    ))
                : <Map<String, dynamic>>[];

            final displayedBrokers = _filterBrokers(allBrokers);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        onChanged: (_) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search broker, agency, city or ID...',
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textSecondary,
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: AppColors.textSecondary,
                                  ),
                                )
                              : null,
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 36,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _filterChip('All'),
                            _filterChip('Needs Review'),
                            _filterChip('Approved'),
                            _filterChip('Changes Requested'),
                            _filterChip('Rejected'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      snapshot.connectionState == ConnectionState.waiting &&
                          !snapshot.hasData
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : snapshot.hasError
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Unable to load brokers. Please check your internet connection and Firestore rules.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      : displayedBrokers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 68,
                                width: 68,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.08,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.business_center_outlined,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'No brokers found',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Try another search or filter',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 2, 20, 20),
                          itemCount: displayedBrokers.length,
                          itemBuilder: (context, index) {
                            return _brokerCard(displayedBrokers[index]);
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(),
    );
  }
}
