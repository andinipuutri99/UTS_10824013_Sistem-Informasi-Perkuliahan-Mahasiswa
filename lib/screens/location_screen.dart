// lib/screens/location_screen.dart

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../constants/app_theme.dart';
import '../widgets/app_card.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? _currentPosition;
  LocationPermission? _permissionStatus;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    try {
      // Tambahkan ini dulu
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _errorMessage = 'Location service dinonaktifkan');
        return;
      }

      final status = await Geolocator.checkPermission();
      setState(() => _permissionStatus = status);
    } catch (e) {
      setState(() => _errorMessage = 'Error checking permission: ${e.toString()}');
    }
  }

  Future<void> _requestLocationPermission() async {
    try {
      final status = await Geolocator.requestPermission();
      setState(() => _permissionStatus = status);

      if (status == LocationPermission.whileInUse ||
          status == LocationPermission.always) {
        await _getCurrentLocation();
      } else if (status == LocationPermission.denied) {
        setState(() => _errorMessage = 'Izin lokasi ditolak');
      } else if (status == LocationPermission.deniedForever) {
        setState(() =>
            _errorMessage = 'Izin lokasi ditolak selamanya. Buka pengaturan aplikasi.');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error requesting permission: ${e.toString()}');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final hasPermission = await Geolocator.checkPermission();
      if (hasPermission == LocationPermission.denied) {
        setState(() => _errorMessage = 'Izin lokasi ditolak');
        return;
      }

      if (hasPermission == LocationPermission.deniedForever) {
        setState(() =>
            _errorMessage = 'Izin lokasi ditolak selamanya. Buka pengaturan aplikasi.');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Lokasi berhasil diperoleh!'),
            backgroundColor: AppColors.primaryContainer,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  String _getPermissionStatusText() {
    if (_permissionStatus == null) return 'Memeriksa izin...';
    switch (_permissionStatus!) {
      case LocationPermission.denied:
        return '❌ Ditolak';
      case LocationPermission.deniedForever:
        return '❌ Ditolak Selamanya';
      case LocationPermission.whileInUse:
        return '✅ Aktif (Saat Digunakan)';
      case LocationPermission.always:
        return '✅ Selalu Aktif';
      case LocationPermission.unableToDetermine:
        return '❓ Tidak Dapat Ditentukan';
    }
  }

  Color _getPermissionStatusColor() {
    switch (_permissionStatus) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        return Colors.red;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return AppColors.primaryContainer;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Get Location',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Dapatkan koordinat lokasi Anda saat ini.',
                style: TextStyle(fontSize: 13, color: Colors.grey[500]),
              ),
              const SizedBox(height: 28),

              // Permission Status Card
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.security_rounded,
                            size: 20, color: AppColors.primaryContainer),
                        SizedBox(width: 8),
                        Text(
                          'Status Izin Lokasi',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: _getPermissionStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getPermissionStatusColor().withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _permissionStatus == LocationPermission.denied ||
                                    _permissionStatus ==
                                        LocationPermission.deniedForever
                                ? Icons.lock_outline_rounded
                                : Icons.check_circle_outline_rounded,
                            color: _getPermissionStatusColor(),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _getPermissionStatusText(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _getPermissionStatusColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_permissionStatus == LocationPermission.denied ||
                        _permissionStatus == LocationPermission.deniedForever)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _requestLocationPermission,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Berikan Izin Lokasi',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Location Data Card
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on_rounded,
                                size: 20, color: AppColors.primaryContainer),
                            SizedBox(width: 8),
                            Text(
                              'Lokasi Terkini',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ],
                        ),
                        if (_currentPosition != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primaryContainer,
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Terbaru',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryContainer,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: CircularProgressIndicator(
                            color: AppColors.primaryContainer,
                          ),
                        ),
                      )
                    else if (_currentPosition != null)
                      Column(
                        children: [
                          _LocationInfoTile(
                            icon: Icons.public_rounded,
                            label: 'Latitude',
                            value:
                                _currentPosition!.latitude.toStringAsFixed(6),
                          ),
                          const SizedBox(height: 12),
                          _LocationInfoTile(
                            icon: Icons.public_rounded,
                            label: 'Longitude',
                            value:
                                _currentPosition!.longitude.toStringAsFixed(6),
                          ),
                          const SizedBox(height: 12),
                          _LocationInfoTile(
                            icon: Icons.speed_rounded,
                            label: 'Akurasi',
                            value:
                                '${_currentPosition!.accuracy.toStringAsFixed(2)} meter',
                          ),
                          const SizedBox(height: 12),
                          _LocationInfoTile(
                            icon: Icons.calendar_today_rounded,
                            label: 'Waktu',
                            value: _formatDateTime(
                                _currentPosition!.timestamp),
                          ),
                        ],
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.location_off_rounded,
                                  size: 30, color: Color(0xFFCBD5E1)),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Lokasi belum diambil',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Get Location Button
              if (_permissionStatus == LocationPermission.whileInUse ||
                  _permissionStatus == LocationPermission.always)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _getCurrentLocation,
                    icon: _isLoading
                        ? const SizedBox.shrink()
                        : const Icon(Icons.my_location_rounded),
                    label: Text(
                      _isLoading ? 'Mengambil Lokasi...' : 'Ambil Lokasi Terkini',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

              // Error Message
              if (_errorMessage != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          size: 20, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class _LocationInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _LocationInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: AppColors.primaryContainer,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
