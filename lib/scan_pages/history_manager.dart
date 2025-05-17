import 'package:dermavsion/scan_pages/scan_record.dart';

class HistoryManager {
  List<ScanRecord> _history = [];

  void addScan(String location) {
    final existingRecord = _history.firstWhere(
          (record) => record.location == location,
      orElse: () => ScanRecord(location: '', count: 0),
    );
    if (existingRecord.location.isNotEmpty) {
      existingRecord.count++;
    } else {
      _history.add(ScanRecord(location: location));
    }
  }

  List<ScanRecord> getHistory() {
    return _history;
  }
}