
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterViews extends StatefulWidget{
  const ConverterViews({super.key});

  @override
  State<ConverterViews> createState() => _ConverterViewsState();


}

class _ConverterViewsState extends State<ConverterViews> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Просмотры в \$\$\$...", "\$\$\$ в просмотры..?"];
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
          int num = ((int.parse(s) / 0.002).round());
          result = "$num просмотров...";

        }else {
          double num = ((double.parse(s) * 0.002) * 1000).round() / 1000;
          result = "$num USD...";
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