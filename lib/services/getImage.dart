import 'dart:convert';

import 'package:http/http.dart' as http;

class GetImage {

  final Uri _apiurl = Uri.parse("https://fakeface.rest/face/json");

  GetImage get instance => GetImage();

  Future<String> getImageFromApi () async{
    http.Response response = await http.get(_apiurl);
    Map<String,dynamic> responseJson = json.decode(response.body);
    return responseJson['image_url'] ?? '';
  }  
}