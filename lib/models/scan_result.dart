import 'dart:convert';

enum ScanType { qrCode, barcode }

class ScanResult {
  final String id;
  final String data;
  final ScanType scanType;
  final DateTime scannedAt;

  ScanResult({
    required this.id,
    required this.data,
    required this.scanType,
    required this.scannedAt,
  });

  factory ScanResult.fromData(String data, String? format) {
    final scanType = _detectScanType(format);

    return ScanResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      data: data,
      scanType: scanType,
      scannedAt: DateTime.now(),
    );
  }

  static ScanType _detectScanType(String? format) {
    if (format == null) return ScanType.qrCode;

    final lowerFormat = format.toLowerCase();
    if (lowerFormat.contains('qr')) {
      return ScanType.qrCode;
    }
    return ScanType.barcode;
  }

  String get scanTypeLabel {
    switch (scanType) {
      case ScanType.qrCode:
        return 'QR CODE';
      case ScanType.barcode:
        return 'BARCODE';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'scanType': scanType.index,
      'scannedAt': scannedAt.toIso8601String(),
    };
  }

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json['id'],
      data: json['data'],
      scanType: ScanType.values[json['scanType']],
      scannedAt: DateTime.parse(json['scannedAt']),
    );
  }

  static String encodeList(List<ScanResult> results) {
    return jsonEncode(results.map((e) => e.toJson()).toList());
  }

  static List<ScanResult> decodeList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => ScanResult.fromJson(e)).toList();
  }
}
