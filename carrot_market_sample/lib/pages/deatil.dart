import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market_sample/components/manor_temperature_widget.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;

  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  Size? size;
  late List<String> imgList = [
    widget.data["image"] as String,
    widget.data["image"] as String,
    widget.data["image"] as String,
    widget.data["image"] as String,
    widget.data["image"] as String,
  ];
  late int _current = 0;

  @override
  void initState() {
    super.initState();
    imgList = [
      widget.data["image"] as String,
      widget.data["image"] as String,
      widget.data["image"] as String,
      widget.data["image"] as String,
      widget.data["image"] as String,
    ];
    _current = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }

  @override
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _makeSliderImage() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.data["cid"]!,
            child: CarouselSlider(
              options: CarouselOptions(
                height: size!.width,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: imgList.map((url) {
                return Image.asset(
                  url,
                  width: size?.width,
                  fit: BoxFit.fill,
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0, right: 0, // 좌우 전체를 사용함
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(
            widget.data["title"] as String,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "디지털/가전 ∙ 22시간 전",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "선물받은 새상품이고\n상품 꺼내보기만 했습니다\n거래는 직거래만 합니다.",
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
          SizedBox(height: 15),
          Text(
            "채팅 3 ∙ 관심 17 ∙ 조회 295",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "판매자님의 판매 상품",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "모두보기",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget _bodyWidget() {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          _makeSliderImage(),
          _sellerSimpleInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _otherCellContents(),
        ])),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            delegate: SliverChildListDelegate(List.generate(21, (index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // 제목 금액 좌측 정렬용
                   children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 120,
                        color: Colors.grey,
                      ),
                    ),
                    Text("상품 제목", style: TextStyle(fontSize: 14),),
                    Text("금액", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ],
                ),
              );
            }).toList()),
          ),
        ),
      ],
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      width: size?.width,
      height: 55,
      color: Colors.red,
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "판매자",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text("서울시 서대문구"),
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 37.5))
        ],
      ),
    );
  }
}
