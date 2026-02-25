import 'package:flutter/material.dart';
import '../data/health_data.dart';
import '../models/health_record.dart';
import '../theme/app_theme.dart';

class FormScreen extends StatefulWidget {
  final HealthRecord? record; // null = tambah baru, tidak null = edit

  const FormScreen({super.key, this.record});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _tanggalController;
  late TextEditingController _namaDokterController;
  late TextEditingController _diagnosisController;
  late TextEditingController _obatController;
  late TextEditingController _tekananDarahController;
  late TextEditingController _beratTinggiController;
  late TextEditingController _catatanController;

  bool get isEdit => widget.record != null;

  @override
  void initState() {
    super.initState();
    final r = widget.record;
    _tanggalController = TextEditingController(text: r?.tanggal ?? '');
    _namaDokterController = TextEditingController(text: r?.namaDokter ?? '');
    _diagnosisController = TextEditingController(text: r?.diagnosis ?? '');
    _obatController = TextEditingController(text: r?.obat ?? '');
    _tekananDarahController = TextEditingController(
      text: r?.tekananDarah ?? '',
    );
    _beratTinggiController = TextEditingController(text: r?.beratTinggi ?? '');
    _catatanController = TextEditingController(text: r?.catatan ?? '');
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _namaDokterController.dispose();
    _diagnosisController.dispose();
    _obatController.dispose();
    _tekananDarahController.dispose();
    _beratTinggiController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final formatted =
          '${picked.day} ${_bulanIndo(picked.month)} ${picked.year}';
      _tanggalController.text = formatted;
    }
  }

  String _bulanIndo(int month) {
    const bulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return bulan[month];
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    if (isEdit) {
      final updated = HealthRecord(
        id: widget.record!.id,
        tanggal: _tanggalController.text.trim(),
        namaDokter: _namaDokterController.text.trim(),
        diagnosis: _diagnosisController.text.trim(),
        obat: _obatController.text.trim(),
        tekananDarah: _tekananDarahController.text.trim(),
        beratTinggi: _beratTinggiController.text.trim(),
        catatan: _catatanController.text.trim(),
      );
      HealthData.updateRecord(updated);
    } else {
      final newRecord = HealthRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tanggal: _tanggalController.text.trim(),
        namaDokter: _namaDokterController.text.trim(),
        diagnosis: _diagnosisController.text.trim(),
        obat: _obatController.text.trim(),
        tekananDarah: _tekananDarahController.text.trim(),
        beratTinggi: _beratTinggiController.text.trim(),
        catatan: _catatanController.text.trim(),
      );
      HealthData.addRecord(newRecord);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEdit ? 'Data berhasil diperbarui!' : 'Data berhasil ditambahkan!',
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Riwayat' : 'Tambah Riwayat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Informasi Pemeriksaan'),
              const SizedBox(height: 12),
              _buildField(
                controller: _tanggalController,
                label: 'Tanggal Pemeriksaan',
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                onTap: _pickDate,
                hint: 'Pilih tanggal',
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _namaDokterController,
                label: 'Nama Dokter / Faskes',
                icon: Icons.person_outline,
                hint: 'Contoh: Dr. Andi Santoso',
              ),
              const SizedBox(height: 22),
              _sectionLabel('Hasil Pemeriksaan'),
              const SizedBox(height: 12),
              _buildField(
                controller: _diagnosisController,
                label: 'Diagnosis',
                icon: Icons.medical_information_outlined,
                hint: 'Contoh: Hipertensi Ringan',
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _obatController,
                label: 'Obat yang Diresepkan',
                icon: Icons.medication_outlined,
                hint: 'Contoh: Amlodipine 5mg',
              ),
              const SizedBox(height: 22),
              _sectionLabel('Data Vital'),
              const SizedBox(height: 12),
              _buildField(
                controller: _tekananDarahController,
                label: 'Tekanan Darah',
                icon: Icons.monitor_heart_outlined,
                hint: 'Contoh: 120/80',
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _beratTinggiController,
                label: 'Berat / Tinggi Badan',
                icon: Icons.straighten_outlined,
                hint: 'Contoh: 65kg / 170cm',
              ),
              const SizedBox(height: 22),
              _sectionLabel('Catatan Tambahan'),
              const SizedBox(height: 12),
              _buildField(
                controller: _catatanController,
                label: 'Catatan',
                icon: Icons.notes_outlined,
                hint: 'Catatan dari dokter atau kondisi lainnya...',
                maxLines: 4,
                isRequired: false,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _simpan,
                  icon: Icon(
                    isEdit ? Icons.save_outlined : Icons.add_circle_outline,
                  ),
                  label: Text(
                    isEdit ? 'Simpan Perubahan' : 'Tambah Riwayat',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        prefixIcon: Icon(icon, color: AppTheme.primary, size: 20),
        suffixIcon: readOnly
            ? const Icon(Icons.arrow_drop_down, color: AppTheme.primary)
            : null,
      ),
      validator: isRequired
          ? (val) {
              if (val == null || val.trim().isEmpty) {
                return '$label tidak boleh kosong';
              }
              return null;
            }
          : null,
    );
  }
}
