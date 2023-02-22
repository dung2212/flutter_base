class ModelUtil {
  /// Lấy dữ liệu dạng string từ map mặc định null
  static String? getString(String key, Map<String, dynamic>? data) {
    if (data == null) {
      return null;
    } else if (data[key] == null) {
      return null;
    } else if (!data.containsKey(key)) {
      return null;
    } else {
      return data[key].toString();
    }
  }

  ///Lấy dữ liệu int từ map mặc định null
  static int? getInt(String key, Map<String, dynamic>? data) {
    if (data == null) {
      return null;
    } else if (data[key] == null) {
      return null;
    } else if (!data.containsKey(key)) {
      return null;
    } else {
      return int.tryParse(data[key].toString());
    }
  }

  /// Lấy dữ liệu double từ map mặc định null
  static double? getDouble(String key, Map<String, dynamic>? data) {
    if (data == null) {
      return null;
    } else if (data[key] == null) {
      return null;
    } else if (!data.containsKey(key)) {
      return null;
    } else {
      return double.tryParse(data[key].toString());
    }
  }

  /// lấy dữ liệu bool từ map mặc định null
  static bool? getBool(String key, Map<String, dynamic>? data) {
    if (data == null) {
      return null;
    } else if (data[key] == null) {
      return null;
    } else if (!data.containsKey(key)) {
      return null;
    } else {
      return data[key] as bool?;
    }
  }

  /// Lấy list double entity
  static List<double> getListDouble(String key, Map<String, dynamic>? data) {
    final List<double> result = <double>[];
    if (data == null) {
      return result;
    }
    if (data[key] == null) {
      return result;
    }
    if (!data.containsKey(key)) {
      return result;
    }

    data[key].forEach((dynamic item) {
      result.add(item as double);
    });
    return result;
  }

  /// Get list int entity
  static List<int> getListInt(String key, Map<String, dynamic>? data) {
    final List<int> result = <int>[];
    if (data == null) {
      return result;
    }
    if (data[key] == null) {
      return result;
    }
    if (!data.containsKey(key)) {
      return result;
    }

    data[key].forEach((dynamic item) {
      result.add(item as int);
    });
    return result;
  }

  /// Get list String entity
  static List<String> getListString(String key, Map<String, dynamic>? data) {
    final List<String> result = <String>[];
    if (data == null) {
      return result;
    }
    if (data[key] == null) {
      return result;
    }
    if (!data.containsKey(key)) {
      return result;
    }

    data[key].forEach((dynamic item) {
      result.add(item.toString());
    });
    return result;
  }
}
