
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterGb extends StatefulWidget{
  const ConverterGb({super.key});

  @override
  State<ConverterGb> createState() => _ConverterGbState();


}

class _ConverterGbState extends State<ConverterGb> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Гиги в байты...", "Байты в гиги..."];
  int currTitle = 0;
  String result = "";

  @override
  void initState() {
    super.initState();
    controller.addListener(() {


      updateResult(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateTitle(){
    setState(() {
      currTitle = currTitle == 0 ? 1 : 0;
    });

  }

  void updateResult(String s){
    setState(() {
      if (s.isEmpty){
        result = "Здесь будет результат...";
      }else {
        if (currTitle == 1){
          double num = ((double.parse(s) / 1073741824));
          if (num < 0.0001){
            result = "Очень мало гигов...";
          }else {
            num = (num * 10000).round() / 10000;
            result = "$num гигабайт...";
          }
        }else {
          result = (int.parse(s) * 1073741824).round().toString();
          result = "$result байт...";
        }
      }
    });
  }

  String beautifyText(String text){

    return text;
  }


  @override
  Widget build(BuildContext context) {
    return Base.createBase(
        GestureDetector(
          onDoubleTap: (){
            updateTitle();
            updateResult(controller.text);
          },
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controller,
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                          fontSize: 20
                      ),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.numbers),
                        hintText: 'Введите число',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(signed: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(result,
                        style: TextStyle(fontSize: 20),),
                    )

                  ],
                ),
              )
          ),
        ),
        title: titles[currTitle]
    );
  }
}