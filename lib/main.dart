import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=>Store1()),
          ChangeNotifierProvider(create: (c)=>Store2()),
        ],
        child: MaterialApp(
          home: MyApp(),
          theme: ThemeData(
            textTheme: TextTheme(
              // body에 사용되는 텍스트의 스타일
              bodyText2: TextStyle(color: Colors.red)
            )

          ),
        ),
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pageIndex = 0;
  var name = '';

  List<Widget> bodyWidget = [
    Text('1'),
    SecondPage(),
    Text('3'),
  ];

  @override
  Widget build(BuildContext context) {

    print(context.read<Store2>().store2);
    return Scaffold(

      appBar: AppBar(),

      body: Center(child: bodyWidget[pageIndex]),

      bottomNavigationBar: BottomNavigationBar(

        //바텀네비게이션바 아이콘 눌렀을때 실행
        onTap: (index){
          setState(() {
            pageIndex=index;
          });
        },

        //현재 인덱스를 설정
        currentIndex: pageIndex,

        //현재 아이콘의 색상
        selectedItemColor: Colors.green,

        //아이콘 종류
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
            label: 'add',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.markunread),
            label: 'massage'
          )
        ],
      )
    );
  }
}


class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.read<Store2>().store2);
  }
}



class Store1 extends ChangeNotifier{
  var pageIndexNum=0;
  changeIndex(index){
    pageIndexNum=index;
    notifyListeners();
  }
}
class Store2 extends ChangeNotifier{
  var store2='store2';
}











