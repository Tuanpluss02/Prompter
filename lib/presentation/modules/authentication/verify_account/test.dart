// Hàm chuyển đổi giá trị
import 'dart:convert';

dynamic getExampleValue(dynamic data) {
  if (data is int) return 0;
  if (data is double) return 0.0;
  if (data is bool) return false;
  if (data is List) return listToString(data); // Nếu là List, xử lý bằng listToString
  if (data is Map) return mapToString(data); // Nếu là Map, xử lý bằng mapToString
  if (data is String) {
    try {
      final contentMap = jsonDecode(data);
      return mapToString(contentMap); // Nếu là Map trá hình String
    } catch (e) {
      return '""';
    }
  }
  return null; // Trường hợp không thuộc các kiểu dữ liệu trên
}

// Hàm chuyển đổi List thành String
String listToString(List<dynamic> list) {
  List<dynamic> modifiedList = list.map((item) => getExampleValue(item)).toList();
  return modifiedList.toString();
}

// Hàm chuyển đổi Map thành String và bọc key vào ""
String mapToString(Map<dynamic, dynamic> map) {
  List<String> entries = map.entries.map((entry) {
    String key = '"${entry.key}"'; // Bọc key vào dấu ngoặc kép
    dynamic value = getExampleValue(entry.value);
    return '$key: $value'; // Tạo chuỗi key-value
  }).toList();

  return '{${entries.join(', ')}}'; // Gộp các entry thành chuỗi map
}
