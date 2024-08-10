import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/dictionary_service.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final DictionaryService _service = DictionaryService();
  List<String> _words = [];
  String _searchQuery = '';

  @override
  void initState(){
    super.initState();
    _fetchWords();
  }

  void _fetchWords() async {
    final words = await _service.fetchAllWords(3000,150);
    setState(() {
      _words = words;
    });
  }


  void _searchWords(String query) async {
    final results = await _service.searchWords(query);
    setState(() {
      _words = results;
      _searchQuery = query;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Dictionary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: (){
              showSearch(context: context, delegate: WordSearch(_words));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _words.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(_words[index]),
          );
        }
      ),
    );
  }
}

class WordSearch extends SearchDelegate<String> {
  final List<String> data; // Original data list

  WordSearch(this.data);

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ""); // Close the search delegate
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
          showSuggestions(context); // Show suggestions again
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // If the query is empty, return the original data
    if (query.isEmpty) {
      return ListView(
        children: data.map((word) => ListTile(title: Text(word))).toList(),
      );
    }

    // Filter the data based on the query
    final results = data.where((word) => word.contains(query)).toList();

    return ListView(
      children: results.map((word) => ListTile(title: Text(word))).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // If the query is empty, return the original data
    if (query.isEmpty) {
      return ListView(
        children: data.map((word) => ListTile(title: Text(word))).toList(),
      );
    }

    // Filter the data based on the query
    final suggestions = data.where((word) => word.startsWith(query)).toList();

    return ListView(
      children: suggestions.map((word) => ListTile(title: Text(word))).toList(),
    );
  }
}

