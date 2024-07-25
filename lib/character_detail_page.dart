import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/character.dart';

class DetailPage extends StatelessWidget {
  final Character _character;

  DetailPage(this._character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildBody(context),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.cyanAccent,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        _character.name,
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

  _buildBody(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 32,
          ),
          _buildImage(context),
          SizedBox(height: 48),
          _buildDetailRow("Status",_character.status),
          SizedBox(height: 24),
          _buildDetailRow("Species",_character.species),
          SizedBox(height: 24),
          _buildDetailRow("Gender",_character.gender),
          SizedBox(height: 24),
          _buildDetailRow("Origin",_character.origin),
          SizedBox(height: 24),
          _buildDetailRow("Location",_character.location),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  _buildImage(BuildContext context) {
    return Image.network(
      _character.image,
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth,
    );
  }

  _buildDetailRow(String head, String detail){
    return Row(
      children: [
        Expanded(
          flex: 3,
            child: Text(
              head,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
              textAlign: TextAlign.end,
            ),
        ),
        SizedBox(width: 32),
        Expanded(
          flex: 8,
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 24,
                color: Colors.purple,
              ),
            )
        )
      ],
    );
  }
}
