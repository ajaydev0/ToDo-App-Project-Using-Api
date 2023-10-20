import 'dart:convert';

import 'package:http/http.dart' as http;

//All Api Calls is here
class TodoService {
  //Delete
  static Future<bool> deleteById(String id) async {
    final url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    final response = await http.delete(url);
    return response.statusCode == 200;
  }

  //TodoListData
  static Future<List?> todoListData() async {
    final url = Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=10");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      final result = data["items"] as List;
      return result;
    } else {
      return null;
    }
  }

  //Update
  static Future<bool> updateData(String id, Map body) async {
    //Submit date to the server
    final uri = Uri.parse("https://api.nstack.in/v1/todos/$id");
    var respose = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    //show success or fail message based on status
    return respose.statusCode == 200;
  }

  //Submit
  static Future<bool> submitData(Map body) async {
    //Submit date to the server
    final uri = Uri.parse("https://api.nstack.in/v1/todos");
    var respose = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    //show success or fail message based on status
    return respose.statusCode == 201;
  }
}
