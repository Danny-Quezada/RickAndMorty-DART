
import 'package:flutter/material.dart';
import 'package:api_rickandmorty/src/domain/models/characterRYM.dart';

class containWidget extends StatelessWidget {
  CharacterRYM character;
  containWidget(this.character);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var radius = Radius.circular(12);
    const textStyle = const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Roboto',fontSize: 20);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: size.height * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff3c3e44),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.only(topLeft: radius, bottomLeft: radius),
              child: FadeInImage(
                alignment: Alignment.topLeft,
                placeholder: const AssetImage(
                  'assets/loading2.gif',
                ),
                image: NetworkImage(
                  '${character.image}',
                ),
                width: size.width * 0.4,
              ),
            ),
            SizedBox(width: size.width*.02,),
            Column(
              children: [
                SizedBox(height: size.height*.014,),
                
                character.name!.length>20 ? Text('${character.name!.substring(0,10)}...',style: textStyle,): 
                Text('${character.name}',style: textStyle,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
