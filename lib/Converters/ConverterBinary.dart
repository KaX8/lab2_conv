
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterBinary extends StatefulWidget{
  const ConverterBinary({super.key});

  @override
  State<ConverterBinary> createState() => _ConverterBinaryState();


}

class _ConverterBinaryState extends State<ConverterBinary> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Десятичное в двоичное", "Двоичное в десятичное"];
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
      if (s.isNotEmpty && currTitle == 1) {

        if(!RegExp("[2-9]").hasMatch(s)){
          result = int.parse(s, radix: 2).toString();
        }else {
          result = "Вы ввели что то неверно...";
        }

      }if (s.isNotEmpty && currTitle == 0) {
        int num = int.parse(s);
        result = num.toRadixString(2);
      }else if (s.isEmpty){
        result = "Здесь будет результат...";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Base.createBase(
        GestureDetector(
          onDoubleTap: (){
            print("DOUBLE!!!");
            updateTitle();
            updateResult(controller.text);
          },
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Смахивание вправо
              print("Swipe right");
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
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly // С таким фильтром могут быть введены только числа
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