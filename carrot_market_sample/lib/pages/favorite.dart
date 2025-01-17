import 'package:carrot_market_sample/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:carrot_market_sample/utils/widgets.dart';

class MyFavoriteContents extends StatefulWidget {
  const MyFavoriteContents({Key? key}) : super(key: key);

  @override
  State<MyFavoriteContents> createState() => _MyFavoriteContentsState();
}

class _MyFavoriteContentsState extends State<MyFavoriteContents> {
  late ContentsRepository contentsRepository;

  PreferredSizeWidget _appbarWidget(){
    return AppBar(
      title: Text("관심목록", style: TextStyle(fontSize: 15),),
    );
  }

  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
  }


  Widget  _bodyWidget(){
    return FutureBuilder(

        future: _loadMyFavoriteContentList(),
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

  Future<List?> _loadMyFavoriteContentList() async{
    return await contentsRepository.loadFavoriteContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}


