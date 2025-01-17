import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/deatil.dart'; // DetailContentView의 경로에 맞게 수정
import '../utils/data_utils.dart'; // DataUtils의 경로에 맞게 수정

Widget makeDataList({
  required BuildContext context,
  required List<dynamic> datas,
}) {
  return ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 11),
    itemBuilder: (BuildContext _context, int index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return DetailContentView(
              data: datas[index],
            );
          }));
          print(datas[index]["title"]);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Hero(
                  tag: datas[index]["cid"]!,
                  child: Image.asset(
                    datas[index]["image"]!,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        datas[index]["title"]!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        datas[index]["location"]!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        DataUtils.calcStringToWon(datas[index]["price"]!),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/heart_off.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(width: 5),
                            Text(datas[index]["likes"]!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
    separatorBuilder: (BuildContext _context, int index) {
      return Container(height: 1, color: Colors.black);
    },
    itemCount: datas.length,
  );
}
