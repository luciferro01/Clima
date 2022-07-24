import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  final String urls;
  Networking(this.urls);

  Future getNetworkData() async {
    String url = urls;
    http.Response response = await http.get(
      Uri.parse(url),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      return decodeData;
    } else {
      print(response.statusCode);
    }
  }
}
