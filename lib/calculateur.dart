import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class Calculateur extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Calculateur();

}
class _Calculateur extends State<Calculateur>{

  String inputUser = "";
  String Resultat = "0";

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    inputUser,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                ),
                Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        Resultat,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 47,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
            ],),
          ),
          Divider(color: Colors.white,),

          Expanded(
            child: Container( 
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  crossAxisSpacing: 12, 
                  mainAxisSpacing: 12
                ),
                itemBuilder: (context, index) => CustomButton(buttonList[index]),
              ),
            ),
          ),
      ],),
    );
  }

Widget CustomButton(String text){
  return InkWell(
    splashColor: Color.fromARGB(255, 240, 240, 240),
    onTap: () {
      setState(() {
        handleButton(text);
      });
    },
    child: Ink(
      decoration: BoxDecoration(
        color: getBgColor(text),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0.5,
            offset: Offset(-3, -3),
          )
        ]
      ),
      child: Center(
        child:  Text(
          text,
          style: TextStyle(
            color: getColor(text),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
        
      ),
    ),
  );
}

getColor(String text){
  if( text == "(" || text == ")" || text == "/" || text == "-" || text == "+" || text == "*" || text == "C"){
    return Color.fromARGB(255, 255, 100, 100);
  }
  return Color.fromARGB(255, 255, 255, 255);
}

getBgColor(String text){
  if( text == "AC"){
    return Color.fromARGB(255, 255, 100, 100);
  }else if(text == "=" ){
    return Color.fromARGB(255, 105, 241, 128);
  }
  return Color(0xFF1d2630);
}

handleButton(String text){
  if(text == "AC"){
    inputUser = "";
    Resultat = "0";
    return;
  }else if(text == "C"){
    if(inputUser.isNotEmpty){ 
      inputUser = inputUser.substring(0, inputUser.length - 1);
      return;
    }else{
      return null;
    }
  }

  if(text == "="){
    Resultat = calculer();
    inputUser = Resultat;

    if(inputUser.endsWith(".0")){
      inputUser = inputUser.replaceAll(".0", "");
    }

    if(Resultat.endsWith(".0")){
      Resultat = Resultat.replaceAll(".0", "");
    }
  }

  inputUser += text;
}
  String calculer(){
    try{
      var exp = Parser().parse(inputUser);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "Syntaxe Error";
    }
  
}

}