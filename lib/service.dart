import 'Model/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  // ignore: body_might_complete_normally_nullable
  static Future<List<DataModel>?> fetchschools() async {
    final response =
        await client.get(Uri.parse('http://universities.hipolabs.com/search'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return dataModelFromJson(jsonString);
    }
  }
}
