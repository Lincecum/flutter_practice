import 'package:carrot_market_sample/pages/deatil.dart';
import 'package:carrot_market_sample/repository/contents_repository.dart';
import 'package:carrot_market_sample/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../utils/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Map<String, String>> datas = [];
  String currentLocation= "아라동";
  ContentsRepository contentsRepository = ContentsRepository();
  final Map<String, String> locationTypeToString = {
    "ara" : "아라동",
    "ora" : "오라동",
    "donam" : "도남동",
  };
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    currentLocation = "아라동";
    contentsRepository = ContentsRepository();
    _currentPageIndex = 0;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    currentLocation = "도남동";
    contentsRepository = ContentsRepository();
  }



  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      // leading: ,
      // backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          print("pressed");
        },
        // onLongPress: (){
        //   print("long pressed")
        // },
        child: PopupMenuButton<String>(
          offset: Offset(0,30),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          onSelected: (String where) {
            print(where);
            setState(() {
              currentLocation = where;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "ara", child: Text("아라동")),
              PopupMenuItem(value: "ora", child: Text("오라동")),
              PopupMenuItem(value: "donam", child: Text("도남동")),
            ];
          },
          child: Row(
            children: [
              Text(
                locationTypeToString[currentLocation] ?? "위치 없음",
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/bell.svg",
              width: 22,
            )),
      ],
    );
  }
  //
  // Widget _makeDataList(List<Map<String,String>> datas) {
  //   return ListView.separated(
  //     padding: const EdgeInsets.symmetric(horizontal: 11),
  //     itemBuilder: (BuildContext _context, int index) {
  //       return GestureDetector(
  //         onTap: (){
  //           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
  //             return DetailContentView(
  //               data: datas[index],
  //             );
  //           }));
  //           print(datas[index]["title"]);
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 11),
  //             child: Row(
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.all(Radius.circular(30)),
  //                   child: Hero(
  //                     tag: datas[index]["cid"]!,
  //                     child: Image.asset(
  //                       datas[index]["image"]!,
  //                       width: 100,
  //                       height: 100,
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     height: 100,
  //                     padding: const EdgeInsets.only(left: 20),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           datas[index]["title"]!,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(fontSize: 15),
  //                         ),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           datas[index]["location"]!,
  //                           style: TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.black.withOpacity(0.3)),
  //                         ),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                             DataUtils.calcStringToWon(datas[index]["price"]!),
  //                             style: TextStyle(fontWeight: FontWeight.w500)),
  //                         Expanded(
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             crossAxisAlignment: CrossAxisAlignment.end,
  //                             children: [
  //                               SvgPicture.asset(
  //                                 "assets/svg/heart_off.svg",
  //                                 width: 13,
  //                                 height: 13,
  //                               ),
  //                               SizedBox(width: 5),
  //                               Text(datas[index]["likes"]!),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             )),
  //       );
  //     },
  //     separatorBuilder: (BuildContext _context, int index) {
  //       return Container(height: 1, color: Colors.black);
  //     },
  //     itemCount: datas.length, // itemcount를 데이터의 길이에 맞게 설정
  //   );
  // }

  Future<List<Map<String, String>>> _loadContent() async {
    // ContentsRepository의 메서드가 Future로 데이터를 반환해야 함
    return await contentsRepository.loadContentsFromLocation(currentLocation);
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: _loadContent(),
        builder: (BuildContext context, dynamic snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.error == "Exception") { // snapshot.hasError로 하면 예외처리 안돼서 옆과 같이 구현
            return Center(child: Text("데이터 오류"));
          };
          if (snapshot.hasData) {
            return makeDataList(
              context: context,
              datas: snapshot.data,
            );
          }

          return Center(child: Text(" 텅 "));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}

// return ListView.separated(
//   // 아이템 사이사이
