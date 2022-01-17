import 'package:flutter/material.dart';

//Option selection Button Kidane's Code
class Soption extends StatelessWidget {
  final String category;
  final dynamic page;

  const Soption(this.category, this.page, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, '/action', arguments: {
            'category': category,
          });
        },
        height: 55.0,
        minWidth: 260.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(
          category,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}

//Name List Esrom's Code
class Nbtn extends StatelessWidget {
  final String sss;
  final dynamic page;
  const Nbtn(this.sss, this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(sss),
      style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15),
          fixedSize: const Size(300, 35),
          side: const BorderSide(width: 1, color: Colors.blue)),
    );
  }
}

//Hani and Merry's Code
class Btn extends StatelessWidget {
  final String sss;
  final double width;
  final double height;
  final double font;
  final dynamic page;
  final dynamic args;

  const Btn(this.sss, this.width, this.height, this.font, this.page, this.args,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path;
    path = args.toString().toLowerCase();

    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/$path', arguments: {
          'selected': sss,
          'category': args,
        });
      },
      child: Text(sss),
      style: OutlinedButton.styleFrom(
          textStyle: TextStyle(fontSize: font),
          fixedSize: Size(width, height),
          side: const BorderSide(width: 1, color: Colors.blue)),
    );
  }
}

//Code for check in and out time Hani's Code
class HaniTime extends StatelessWidget {
  final String time;
  const HaniTime(this.time, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.blue.shade500,
          ),
        ),
      ),
    );
  }
}
