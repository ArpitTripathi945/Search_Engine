import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryService {
  static const String baseUrl = 'http://localhost:8080/api/words';

  
  Future<List<String>> fetchAllWords(int page, int pageSize) async {
    
    final response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode == 200){
      final List<dynamic> body = json.decode(response.body);
      return body.map((word) => word['word'] as String).toList();
    }
    else{
      throw Exception('Failed to load words');
    }
  }



  Future<List<String>> searchWords(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?query=$query'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(response.body);
      final List<String> words = body.map((item) => item as String).toList();
      return words;
    }
    else{
      throw Exception('Failed to load search results');
    }
  }

}
