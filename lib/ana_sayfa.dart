import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/character.dart';
import 'package:rick_and_morty/character_detail_page.dart';

class AnaSayfa extends StatefulWidget {

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final String _apiUrl = "https://rickandmortyapi.com/api/character";

  List<Character> _allCharacters = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _pullData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _allCharacters.isNotEmpty ? _buildBody(): Center(child: CircularProgressIndicator())
    );
  }

  void _pullData() async{
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    Map<String,dynamic> parsedResponse = jsonDecode(response.body);

    List<dynamic> charactersJson = parsedResponse["results"];

    for(int i=0; i<charactersJson.length;i++){
      Map<String,dynamic> characterMap = charactersJson[i];
      Character character = Character.fromMap(characterMap);
      _allCharacters.add(character);
    };
    setState(() {

    });
}

  _buildAppBar() {
    return AppBar(
      title: Text(
        "Rick And Morty",
        style: GoogleFonts.creepster(
            textStyle: TextStyle(
              color: Colors.purple,
              fontSize: 42,
            )
        ),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    );
  }

  _buildBody() {
    return Container(
      color: Colors.cyanAccent,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Her satırda 2 kart olacak şekilde
          childAspectRatio: 3 / 2, // Kartların en/boy oranı
        ),
          itemCount: _allCharacters.length,
          itemBuilder: _buildListItem,
      ),
    );
  }

  Widget? _buildListItem(BuildContext context, int index) {
    Character character = _allCharacters[index];

    return Card(
      color: Colors.black,
      child: InkWell(
        child: Column(
          children: [
            SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: NetworkImage(character.image),
              radius: 32,
            ),
            SizedBox(height: 16),
            Text(
              character.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        onTap: (){
          _clickCharacter(context,character);
        },
      ),
    );
  }

  void _clickCharacter(BuildContext context, Character character) {
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context){
      return DetailPage(character);
    });
    Navigator.push(context, pageRoute);
  }
}