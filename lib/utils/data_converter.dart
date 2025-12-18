// utils/data_converter.dart
class DataConverter {
  // 基础类型转换
  static T basicConverter<T>(dynamic data) {
    if (data is T) {
      return data;
    }
    throw Exception('数据类型不匹配: 期望 $T，实际 ${data.runtimeType}');
  }

  // 列表转换
  static List<T> listConverter<T>(
      dynamic data,
      T Function(Map<String, dynamic>) fromJson,
      ) {
    if (data is! List) {
      throw Exception('期望 List 类型，实际 ${data.runtimeType}');
    }
    return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
  }

  // 对象转换
  static T mapConverter<T>(
      dynamic data,
      T Function(Map<String, dynamic>) fromJson,
      ) {
    if (data is! Map<String, dynamic>) {
      throw Exception('期望 Map 类型，实际 ${data.runtimeType}');
    }
    return fromJson(data);
  }

  // 日期时间转换
  static DateTime? dateTimeConverter(dynamic data) {
    if (data is String) {
      return DateTime.tryParse(data);
    }
    return null;
  }
}