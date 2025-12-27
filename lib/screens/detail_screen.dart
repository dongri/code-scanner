import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../models/scan_result.dart';
import '../services/scan_history_service.dart';
import '../theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final ScanResult result;

  const DetailScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.backgroundDark, Color(0xFF0D0D14)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDataCard(context),
                      const SizedBox(height: 20),
                      _buildGeneratedCodeCard(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardDark,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.borderColor, width: 1),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppTheme.primaryCyan,
                size: 24,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderColor, width: 1),
            ),
            child: const Text(
              'SCAN RESULT',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryCyan,
                letterSpacing: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _showDeleteDialog(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardDark,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.borderColor, width: 1),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: AppTheme.accentPink,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCyan.withAlpha(26),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.data_object,
                      color: AppTheme.primaryCyan,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'DATA',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryCyan,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (result.scanType == ScanType.qrCode
                                  ? AppTheme.primaryCyan
                                  : AppTheme.accentGreen)
                              .withAlpha(38),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color:
                            (result.scanType == ScanType.qrCode
                                    ? AppTheme.primaryCyan
                                    : AppTheme.accentGreen)
                                .withAlpha(77),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      result.scanTypeLabel,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: result.scanType == ScanType.qrCode
                            ? AppTheme.primaryCyan
                            : AppTheme.accentGreen,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.borderColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.copy, size: 14, color: AppTheme.textSecondary),
                      SizedBox(width: 6),
                      Text(
                        'COPY',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textSecondary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppTheme.borderColor.withAlpha(128),
                width: 1,
              ),
            ),
            child: SelectableText(
              result.data,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedCodeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (result.scanType == ScanType.qrCode
                          ? AppTheme.primaryCyan
                          : AppTheme.accentGreen)
                      .withAlpha(26),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  result.scanType == ScanType.qrCode
                      ? Icons.qr_code_2
                      : Icons.view_week,
                  color: result.scanType == ScanType.qrCode
                      ? AppTheme.primaryCyan
                      : AppTheme.accentGreen,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                result.scanType == ScanType.qrCode
                    ? 'GENERATED QR CODE'
                    : 'GENERATED BARCODE',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: result.scanType == ScanType.qrCode
                      ? AppTheme.primaryCyan
                      : AppTheme.accentGreen,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: (result.scanType == ScanType.qrCode
                          ? AppTheme.primaryCyan
                          : AppTheme.accentGreen)
                      .withAlpha(51),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: result.scanType == ScanType.qrCode
                  ? QrImageView(
                      data: result.data,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Color(0xFF1A1A2E),
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color(0xFF1A1A2E),
                      ),
                    )
                  : BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: result.data,
                      width: 280,
                      height: 100,
                      color: const Color(0xFF1A1A2E),
                      backgroundColor: Colors.white,
                      drawText: true,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              result.scanType == ScanType.qrCode
                  ? 'Scan this QR code to get the data'
                  : 'Scan this barcode to get the data',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: AppTheme.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: result.data));
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.accentGreen, size: 20),
            SizedBox(width: 12),
            Text('Copied!', style: TextStyle(fontFamily: 'monospace')),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: const Text(
          'Are you sure you want to delete this scan result?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ScanHistoryService>().removeScanResult(result.id);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppTheme.accentPink),
            ),
          ),
        ],
      ),
    );
  }
}
