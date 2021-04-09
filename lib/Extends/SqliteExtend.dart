enum SqliteDataType {
  int,
  real,
  text,
}

class SqliteColumn {
  final String columnName;
  final String defaultValue;
  final SqliteDataType dataType;
  final bool primaryKey;
  final bool autoincrement;

  String get dataTypeString {
    switch (dataType) {
      case SqliteDataType.text:
        return "TEXT";
      case SqliteDataType.real:
        return "REAL";
      case SqliteDataType.int:
        return "INTEGER";
    }

    return "";
  }

  SqliteColumn({
    this.columnName,
    this.defaultValue,
    this.dataType,
    this.primaryKey = false,
    this.autoincrement = false,
  });

  String get toLine {
    return "$columnName ";
  }

  static String generateCrateTable(String tableName, List<SqliteColumn> listColumn) {
    String query = "CREATE TABLE if not exists $tableName (";
    var arrayStringValue = new List<String>();
    for (var cl in listColumn) {
      var list = new List<String>();
      list.add(cl.columnName);
      list.add(cl.dataTypeString);
      if (cl.primaryKey) list.add("primary key");
      if (cl.autoincrement) list.add("autoincrement");
      arrayStringValue.add(list.join(" "));
    }
    query += arrayStringValue.join(",\n");
    query += ");";
    return query;
  }

  static List<String> generateListColumn(List<SqliteColumn> listColumn) {
    var list = new List<String>();
    for (var cl in listColumn) {
      list.add(cl.columnName);
    }
    return list;
  }
}
