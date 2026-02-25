import '../models/health_record.dart';

class HealthData {
  static final List<HealthRecord> records = [
    HealthRecord(
      id: '1',
      tanggal: '10 Januari 2025',
      namaDokter: 'Dr. Andi Santoso',
      diagnosis: 'Hipertensi Ringan',
      obat: 'Amlodipine 5mg',
      tekananDarah: '140/90',
      beratTinggi: '72kg / 168cm',
      catatan: 'Kurangi konsumsi garam dan istirahat cukup.',
    ),
    HealthRecord(
      id: '2',
      tanggal: '25 Februari 2025',
      namaDokter: 'Dr. Sari Dewi',
      diagnosis: 'ISPA (Infeksi Saluran Pernapasan)',
      obat: 'Amoxicillin 500mg, Parasetamol 500mg',
      tekananDarah: '120/80',
      beratTinggi: '72kg / 168cm',
      catatan: 'Minum air putih yang banyak dan hindari udara dingin.',
    ),
  ];

  static void addRecord(HealthRecord record) {
    records.add(record);
  }

  static void updateRecord(HealthRecord updated) {
    final index = records.indexWhere((r) => r.id == updated.id);
    if (index != -1) {
      records[index] = updated;
    }
  }

  static void deleteRecord(String id) {
    records.removeWhere((r) => r.id == id);
  }
}
