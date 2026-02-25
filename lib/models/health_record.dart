class HealthRecord {
  final String id;
  String tanggal;
  String namaDokter;
  String diagnosis;
  String obat;
  String tekananDarah;
  String beratTinggi;
  String catatan;

  HealthRecord({
    required this.id,
    required this.tanggal,
    required this.namaDokter,
    required this.diagnosis,
    required this.obat,
    required this.tekananDarah,
    required this.beratTinggi,
    required this.catatan,
  });
}
