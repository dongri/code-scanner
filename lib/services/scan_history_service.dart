import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scan_result.dart';

class ScanHistoryService extends ChangeNotifier {
  static const String _storageKey = 'scan_history';
  List<ScanResult> _history = [];
  bool _isLoading = true;

  List<ScanResult> get history => List.unmodifiable(_history);
  bool get isLoading => _isLoading;

  ScanHistoryService() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        _history = ScanResult.decodeList(jsonString);
        _history.sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addScanResult(ScanResult result) async {
    _history.insert(0, result);
    notifyListeners();
    await _saveHistory();
  }

  Future<void> removeScanResult(String id) async {
    _history.removeWhere((item) => item.id == id);
    notifyListeners();
    await _saveHistory();
  }

  Future<void> clearHistory() async {
    _history.clear();
    notifyListeners();
    await _saveHistory();
  }

  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = ScanResult.encodeList(_history);
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      debugPrint('Error saving history: $e');
    }
  }

  ScanResult? getById(String id) {
    try {
      return _history.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
