import 'package:flutter/material.dart';
import '../data/health_data.dart';
import '../models/health_record.dart';
import '../theme/app_theme.dart';
import 'form_screen.dart';

class DetailScreen extends StatefulWidget {
  final HealthRecord record;

  const DetailScreen({super.key, required this.record});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late HealthRecord _record;

  @override
  void initState() {
    super.initState();
    _record = widget.record;
  }

  void _hapus() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppTheme.danger),
            SizedBox(width: 8),
            Text('Hapus Data'),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus data riwayat "${_record.diagnosis}"? Data yang dihapus tidak dapat dikembalikan.',
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.danger),
            onPressed: () {
              HealthData.deleteRecord(_record.id);
              Navigator.pop(context); // tutup dialog
              Navigator.pop(context); // kembali ke list
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Data berhasil dihapus'),
                  backgroundColor: AppTheme.danger,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FormScreen(record: _record)),
              );
              // Refresh data setelah edit
              final updated = HealthData.records.firstWhere(
                (r) => r.id == _record.id,
                orElse: () => _record,
              );
              setState(() => _record = updated);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white70),
            tooltip: 'Hapus',
            onPressed: _hapus,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.medical_services_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _record.diagnosis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _record.namaDokter,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _record.tanggal,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Vital signs row
                  Row(
                    children: [
                      Expanded(
                        child: _VitalCard(
                          icon: Icons.monitor_heart_outlined,
                          label: 'Tekanan Darah',
                          value: _record.tekananDarah,
                          unit: 'mmHg',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _VitalCard(
                          icon: Icons.straighten_outlined,
                          label: 'Berat / Tinggi',
                          value: _record.beratTinggi,
                          unit: '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _DetailSection(
                    icon: Icons.medication_outlined,
                    title: 'Obat yang Diresepkan',
                    content: _record.obat,
                  ),
                  const SizedBox(height: 12),
                  _DetailSection(
                    icon: Icons.notes_outlined,
                    title: 'Catatan Dokter',
                    content: _record.catatan.isEmpty
                        ? 'Tidak ada catatan'
                        : _record.catatan,
                    isSecondary: _record.catatan.isEmpty,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _hapus,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppTheme.danger,
                          ),
                          label: const Text(
                            'Hapus',
                            style: TextStyle(color: AppTheme.danger),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.danger),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FormScreen(record: _record),
                              ),
                            );
                            final updated = HealthData.records.firstWhere(
                              (r) => r.id == _record.id,
                              orElse: () => _record,
                            );
                            setState(() => _record = updated);
                          },
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const _VitalCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
          if (unit.isNotEmpty)
            Text(
              unit,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
            ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final bool isSecondary;

  const _DetailSection({
    required this.icon,
    required this.title,
    required this.content,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppTheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppTheme.primaryLight),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              color: isSecondary
                  ? AppTheme.textSecondary
                  : AppTheme.textPrimary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
