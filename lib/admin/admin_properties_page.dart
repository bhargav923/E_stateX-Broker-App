import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/widgets/admin_bottom_navbar.dart';

class AdminPropertiesPage extends StatefulWidget {
  const AdminPropertiesPage({super.key});

  @override
  State<AdminPropertiesPage> createState() => _AdminPropertiesPageState();
}

class _AdminPropertiesPageState extends State<AdminPropertiesPage> {
  final TextEditingController searchController = TextEditingController();

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> properties = [
    {
      'title': 'Modern 3 BHK House',
      'type': 'House',
      'location': 'Kalawad Road, Rajkot',
      'price': '₹78 Lakh',
      'broker': 'Rajesh Estate',
      'brokerPhone': '+91 98765 43210',
      'owner': 'Rahul Patel',
      'ownerPhone': '+91 98765 11111',
      'status': 'Active',
      'verification': 'Approved',
      'listed': '20 Sep 2026',
      'area': '1850 sq.ft',
      'bedrooms': 3,
      'bathrooms': 2,
      'propertyId': 'EST-10021',
      'surveyNumber': 'SR-4582',
      'documents': [
        {
          'name': 'Ownership Document',
          'type': 'PDF',
          'status': 'Verified',
          'date': '20 Sep 2026',
        },
        {
          'name': 'Sale Deed / Registry',
          'type': 'PDF',
          'status': 'Verified',
          'date': '20 Sep 2026',
        },
        {
          'name': 'Property Tax Receipt',
          'type': 'PDF',
          'status': 'Verified',
          'date': '20 Sep 2026',
        },
        {
          'name': 'Owner ID Proof',
          'type': 'PDF',
          'status': 'Verified',
          'date': '20 Sep 2026',
        },
        {
          'name': 'Address Proof',
          'type': 'PDF',
          'status': 'Verified',
          'date': '20 Sep 2026',
        },
      ],
    },
    {
      'title': 'Premium Farm Land',
      'type': 'Farm',
      'location': 'Gondal Road, Rajkot',
      'price': '₹1.25 Cr',
      'broker': 'Patel Properties',
      'brokerPhone': '+91 98252 45678',
      'owner': 'Mahesh Patel',
      'ownerPhone': '+91 98252 11122',
      'status': 'Active',
      'verification': 'Needs Review',
      'listed': '19 Sep 2026',
      'area': '2.5 Acre',
      'bedrooms': 0,
      'bathrooms': 0,
      'propertyId': 'EST-10022',
      'surveyNumber': 'SR-7854',
      'documents': [
        {
          'name': 'Ownership Document',
          'type': 'PDF',
          'status': 'Pending',
          'date': '19 Sep 2026',
        },
        {
          'name': '7/12 Land Record',
          'type': 'PDF',
          'status': 'Pending',
          'date': '19 Sep 2026',
        },
        {
          'name': 'Property Tax Receipt',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '19 Sep 2026',
        },
        {
          'name': 'Owner ID Proof',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '19 Sep 2026',
        },
        {
          'name': 'Address Proof',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '19 Sep 2026',
        },
      ],
    },
    {
      'title': 'Luxury 4 BHK Villa',
      'type': 'Villa',
      'location': 'Vesu, Surat',
      'price': '₹1.85 Cr',
      'broker': 'Shah Realty',
      'brokerPhone': '+91 99045 67890',
      'owner': 'Amit Shah',
      'ownerPhone': '+91 99045 22222',
      'status': 'Active',
      'verification': 'Approved',
      'listed': '17 Sep 2026',
      'area': '3200 sq.ft',
      'bedrooms': 4,
      'bathrooms': 4,
      'propertyId': 'EST-10023',
      'surveyNumber': 'SR-6231',
      'documents': [
        {
          'name': 'Ownership Document',
          'type': 'PDF',
          'status': 'Verified',
          'date': '17 Sep 2026',
        },
        {
          'name': 'Sale Deed / Registry',
          'type': 'PDF',
          'status': 'Verified',
          'date': '17 Sep 2026',
        },
        {
          'name': 'Property Tax Receipt',
          'type': 'PDF',
          'status': 'Verified',
          'date': '17 Sep 2026',
        },
        {
          'name': 'Owner ID Proof',
          'type': 'PDF',
          'status': 'Verified',
          'date': '17 Sep 2026',
        },
        {
          'name': 'Address Proof',
          'type': 'PDF',
          'status': 'Verified',
          'date': '17 Sep 2026',
        },
      ],
    },
    {
      'title': 'Residential Plot',
      'type': 'Plot',
      'location': 'SG Highway, Ahmedabad',
      'price': '₹62 Lakh',
      'broker': 'Patel Properties',
      'brokerPhone': '+91 98252 45678',
      'owner': 'Kunal Patel',
      'ownerPhone': '+91 98252 33333',
      'status': 'Active',
      'verification': 'Needs Review',
      'listed': '15 Sep 2026',
      'area': '1800 sq.ft',
      'bedrooms': 0,
      'bathrooms': 0,
      'propertyId': 'EST-10024',
      'surveyNumber': 'SR-9124',
      'documents': [
        {
          'name': 'Ownership Document',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '15 Sep 2026',
        },
        {
          'name': 'Sale Deed / Registry',
          'type': 'PDF',
          'status': 'Pending',
          'date': '15 Sep 2026',
        },
        {
          'name': 'Property Tax Receipt',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '15 Sep 2026',
        },
        {
          'name': 'Owner ID Proof',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '15 Sep 2026',
        },
        {
          'name': 'Address Proof',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '15 Sep 2026',
        },
      ],
    },
    {
      'title': '2 BHK Apartment',
      'type': 'Apartment',
      'location': 'Gotri, Vadodara',
      'price': '₹48 Lakh',
      'broker': 'Dream Homes',
      'brokerPhone': '+91 98790 11223',
      'owner': 'Neha Mehta',
      'ownerPhone': '+91 98790 44444',
      'status': 'Disabled',
      'verification': 'Rejected',
      'listed': '12 Sep 2026',
      'area': '1250 sq.ft',
      'bedrooms': 2,
      'bathrooms': 2,
      'propertyId': 'EST-10025',
      'surveyNumber': 'SR-3478',
      'documents': [
        {
          'name': 'Ownership Document',
          'type': 'PDF',
          'status': 'Rejected',
          'date': '12 Sep 2026',
        },
        {
          'name': 'Sale Deed / Registry',
          'type': 'PDF',
          'status': 'Rejected',
          'date': '12 Sep 2026',
        },
        {
          'name': 'Property Tax Receipt',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '12 Sep 2026',
        },
        {
          'name': 'Owner ID Proof',
          'type': 'PDF',
          'status': 'Uploaded',
          'date': '12 Sep 2026',
        },
      ],
    },
    {
      'title': 'Agricultural Land',
      'type': 'Farm',
      'location': 'Gandhinagar',
      'price': '₹92 Lakh',
      'broker': 'Green Land Brokers',
      'brokerPhone': '+91 98123 66789',
      'owner': 'Jignesh Patel',
      'ownerPhone': '+91 98123 55555',
      'status': 'Active',
      'verification': 'Changes Requested',
      'listed': '10 Sep 2026',
      'area': '1.8 Acre',
      'bedrooms': 0,
      'bathrooms': 0,
      'propertyId': 'EST-10026',
      'surveyNumber': 'SR-5521',
      'documents': [
        {
          'name': 'Ownership Document',
          'type': 'PDF',
          'status': 'Verified',
          'date': '10 Sep 2026',
        },
        {
          'name': '7/12 Land Record',
          'type': 'PDF',
          'status': 'Needs Update',
          'date': '10 Sep 2026',
        },
        {
          'name': 'Property Tax Receipt',
          'type': 'PDF',
          'status': 'Verified',
          'date': '10 Sep 2026',
        },
        {
          'name': 'Owner ID Proof',
          'type': 'PDF',
          'status': 'Verified',
          'date': '10 Sep 2026',
        },
        {
          'name': 'Address Proof',
          'type': 'PDF',
          'status': 'Needs Update',
          'date': '10 Sep 2026',
        },
      ],
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredProperties {
    final query = searchController.text.trim().toLowerCase();

    return properties.where((property) {
      final matchesSearch =
          property['title'].toString().toLowerCase().contains(query) ||
          property['location'].toString().toLowerCase().contains(query) ||
          property['broker'].toString().toLowerCase().contains(query) ||
          property['owner'].toString().toLowerCase().contains(query) ||
          property['propertyId'].toString().toLowerCase().contains(query);

      final matchesFilter =
          selectedFilter == 'All' ||
          property['verification'].toString() == selectedFilter;

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
      default:
        return AppColors.warning;
    }
  }

  Color _propertyStatusColor(String status) {
    switch (status) {
      case 'Active':
        return AppColors.success;
      case 'Disabled':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  IconData _propertyIcon(String type) {
    switch (type) {
      case 'House':
        return Icons.home_outlined;
      case 'Villa':
        return Icons.villa_outlined;
      case 'Apartment':
        return Icons.apartment_outlined;
      case 'Plot':
        return Icons.landscape_outlined;
      case 'Farm':
        return Icons.agriculture_outlined;
      default:
        return Icons.home_work_outlined;
    }
  }

  void _showPropertyDetails(Map<String, dynamic> property) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.92,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 15),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        _propertyIcon(property['type']),
                        color: AppColors.primary,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property['title'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            property['propertyId'],
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _statusBadge(
                      property['verification'],
                      _verificationColor(property['verification']),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(
                          'Property Information',
                          Icons.home_work_outlined,
                        ),
                        const SizedBox(height: 10),
                        _infoGrid(property),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Owner Details',
                          Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 10),
                        _personCard(
                          property['owner'],
                          property['ownerPhone'],
                          Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Broker Details',
                          Icons.business_center_outlined,
                        ),
                        const SizedBox(height: 10),
                        _personCard(
                          property['broker'],
                          property['brokerPhone'],
                          Icons.business_center_outlined,
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Verification Documents',
                          Icons.folder_open_outlined,
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(property['documents'].length, (index) {
                          return _documentCard(property['documents'][index]);
                        }),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Verification Checklist',
                          Icons.checklist_rounded,
                        ),
                        const SizedBox(height: 10),
                        _checklistItem(
                          'Ownership document',
                          property['documents'][0]['status'] == 'Verified',
                        ),
                        _checklistItem(
                          'Property / Land record',
                          property['documents'].length > 1 &&
                              property['documents'][1]['status'] == 'Verified',
                        ),
                        _checklistItem(
                          'Property tax receipt',
                          property['documents'].length > 2 &&
                              property['documents'][2]['status'] == 'Verified',
                        ),
                        _checklistItem(
                          'Owner identity proof',
                          property['documents'].length > 3 &&
                              property['documents'][3]['status'] == 'Verified',
                        ),
                        _checklistItem(
                          'Address proof',
                          property['documents'].length > 4 &&
                              property['documents'][4]['status'] == 'Verified',
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          'Admin Verification Note',
                          Icons.edit_note_rounded,
                        ),
                        const SizedBox(height: 10),
                        TextField(
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
                          'Property Control',
                          Icons.admin_panel_settings_outlined,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _togglePropertyStatus(property);
                            },
                            icon: Icon(
                              property['status'] == 'Disabled'
                                  ? Icons.check_circle_outline
                                  : Icons.block_outlined,
                            ),
                            label: Text(
                              property['status'] == 'Disabled'
                                  ? 'Enable Property'
                                  : 'Disable Property',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: property['status'] == 'Disabled'
                                  ? AppColors.success
                                  : AppColors.error,
                              side: BorderSide(
                                color: property['status'] == 'Disabled'
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
                _verificationActions(property),
              ],
            ),
          ),
        );
      },
    );
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

  Widget _infoGrid(Map<String, dynamic> property) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _smallInfo('Price', property['price'])),
              Expanded(child: _smallInfo('Type', property['type'])),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(child: _smallInfo('Area', property['area'])),
              Expanded(
                child: _smallInfo('Survey No.', property['surveyNumber']),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(child: _smallInfo('Location', property['location'])),
              Expanded(child: _smallInfo('Listed', property['listed'])),
            ],
          ),
          if (property['bedrooms'] > 0 || property['bathrooms'] > 0) ...[
            const SizedBox(height: 13),
            Row(
              children: [
                Expanded(
                  child: _smallInfo('Bedrooms', '${property['bedrooms']}'),
                ),
                Expanded(
                  child: _smallInfo('Bathrooms', '${property['bathrooms']}'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _smallInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 9),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _personCard(String name, String phone, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  phone,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.phone_outlined,
            color: AppColors.textSecondary,
            size: 18,
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
                  '${document['type']} • ${document['date']}',
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
                    fontSize: 16,
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
                      document['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
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
                    'Status',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
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

  Widget _verificationActions(Map<String, dynamic> property) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              _requestCorrection(property);
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
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _approveProperty(property);
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
              'Approve',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _rejectProperty(property);
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
              'Reject',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  void _approveProperty(Map<String, dynamic> property) {
    setState(() {
      property['verification'] = 'Approved';
      property['status'] = 'Active';

      for (final document in property['documents']) {
        if (document['status'] == 'Uploaded' ||
            document['status'] == 'Pending') {
          document['status'] = 'Verified';
        }
      }
    });
  }

  void _requestCorrection(Map<String, dynamic> property) {
    setState(() {
      property['verification'] = 'Changes Requested';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Correction request sent to broker'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _rejectProperty(Map<String, dynamic> property) {
    setState(() {
      property['verification'] = 'Rejected';
      property['status'] = 'Disabled';
    });
  }

  void _togglePropertyStatus(Map<String, dynamic> property) {
    setState(() {
      if (property['status'] == 'Disabled') {
        property['status'] = 'Active';
      } else {
        property['status'] = 'Disabled';
      }
    });
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

  Widget _pendingReviewBox(Map<String, dynamic> property) {
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
              Icons.pending_actions_rounded,
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
                  'Documents need admin review',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 9),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showPropertyDetails(property);
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

  Widget _propertyCard(Map<String, dynamic> property) {
    final verificationColor = _verificationColor(property['verification']);

    final statusColor = _propertyStatusColor(property['status']);

    final needsReview =
        property['verification'] == 'Needs Review' ||
        property['verification'] == 'Changes Requested';

    return GestureDetector(
      onTap: () {
        _showPropertyDetails(property);
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
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _propertyIcon(property['type']),
                    color: AppColors.primary,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property['title'],
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
                          Expanded(
                            child: Text(
                              property['location'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        property['propertyId'],
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
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
                    Icons.currency_rupee_rounded,
                    property['price'],
                    'Price',
                  ),
                ),
                Expanded(
                  child: _cardInfo(
                    Icons.square_foot_outlined,
                    property['area'],
                    'Area',
                  ),
                ),
                Expanded(
                  child: _cardInfo(
                    Icons.category_outlined,
                    property['type'],
                    'Type',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _statusBadge(property['verification'], verificationColor),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      property['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    property['broker'].toString().substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Listed by',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        property['broker'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (needsReview) _pendingReviewBox(property),
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
    final displayedProperties = filteredProperties;

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
              'Properties',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Review properties and documents',
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
        child: Column(
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
                      hintText: 'Search property, owner or broker...',
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
              child: displayedProperties.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 68,
                            width: 68,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.home_work_outlined,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'No properties found',
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
                      itemCount: displayedProperties.length,
                      itemBuilder: (context, index) {
                        return _propertyCard(displayedProperties[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(),
    );
  }
}
