import 'package:http/http.dart' as http;
import 'dart:convert';

class CrowdCRUD {
  static get_place(String pinCode) async {
    String url = "http://postalpincode.in/api/pincode/${pinCode}";
    final response = await http.get(url);
    dynamic data = json.decode(response.body)['PostOffice'][0];
    return "${data['Name']} : ${data['Division']}";
  }
}
