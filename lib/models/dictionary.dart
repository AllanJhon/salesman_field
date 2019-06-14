import 'package:saller_demo01/untils/sql.dart';

class Dictionary {
  String type;
  String key;
  String value;
  List<Dictionary> dictionarys;

  Dictionary({this.type, this.key,this.value});

  Dictionary.fromJSON(Map data) {
    
    List<Dictionary> customers = [];
    List list=data['rows'];
    list.forEach((item) {
      Dictionary customer = Dictionary.get(item);
      customers.add(customer);
    });
    this.dictionarys = customers;
    print(customers.length);
  }

  Dictionary.get(Map data):
    type = data['type'],
    key = data['key'],
    value = data['value'];

  Map toMap() {
    return {
      'type': type,
      'value': value,
      'key': key
    };
  }

  Map toSqlCondition() {
    Map _map = this.toMap();
    Map condition = {};
    _map.forEach((k, value) {

      if (value != null) {

        condition[k] = value;
      }
    });

    if (condition.isEmpty) {
      return {};
    }

    return condition;
  }
}

class DictionaryControlModel{
  final String table = 'dictionary';
  Sql sql;
  DictionaryControlModel() {
    sql = Sql.setTable(table);
  }

  // 获取指定类型的数据字典
  Future<List<Dictionary>> getDictionaryByType(String type) async {
    List listjson = await sql.getByCondition(conditions: {'type': type});
    if (listjson.isEmpty) {
      return null;
    }
    List<Dictionary> dictionarys = listjson.map((json) {
      return new Dictionary.get(json);
    }).toList();
    return dictionarys;
  }
}