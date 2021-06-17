import 'dart:convert';

import 'package:http/http.dart' as http;

class GetImage {
  final Uri _apiurl = Uri.parse("");


  GetImage get instance => GetImage();

  Future<String> getImageFromApi () async{
    http.Response response = await http.get(_apiurl);
    Map<String,String> response_json = json.decode(response.body);
    return response_json['image_url'] ?? '';
  }  
}