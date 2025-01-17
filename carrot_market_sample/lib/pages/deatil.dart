import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market_sample/components/manor_temperature_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../repository/contents_repository.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;

  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> with SingleTickerProviderStateMixin{
  Size? size;
  late List<String> imgList = [
    widget.data["image"] as String,
    widget.data["image"] as String,
    widget.data["image"] as String,
    widget.data["image"] as String,
    widget.data["image"] as String,
  ];
  late int _current = 0;
  ScrollController _controller = ScrollController();
  ContentsRepository contentsRepository = ContentsRepository();
  double scrollpositionToAlpha =0;

  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  bool isMyFavoriteContent = false;
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500),); // 멤버 변수로 초기화
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController); // 멤버 변수로 초기화

    _controller.addListener((){
      // print("When Scroll starts this sentence is logged ${_controller.offset}" );
      setState(() {
        if (_controller.offset > 255) {
          scrollpositionToAlpha = 255;
          print(scrollpositionToAlpha);
        } else{
          scrollpositionToAlpha = _controller.offset;
          print(scrollpositionToAlpha);
        }
        _animationController.value = scrollpositionToAlpha/255;
      });
    });
    _loadMyFavoriteContentState();
  }

  _loadMyFavoriteContentState() async{
    bool isFavorite = await contentsRepository.isMyFavoriteContents(widget.data["cid"]!); // 상품 매번 다시 들어갈때, 지금 보는 컨텐츠가 내가 좋아하는 컨텐츠인지 확인하는 내용
    setState(() {
      isMyFavoriteContent = isFavorite;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
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

  Widget _makeIcon(IconData icon){
    return AnimatedBuilder(
        animation: _colorTween, builder: (context, child) => Icon(icon, color: _colorTween.value,)
    );
  }

  @override
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()), // 0~255 사이로 세팅
      elevation: 0,
      leading: IconButton(
        icon: AnimatedBuilder(animation: _colorTween, builder: (context, child) => Icon(Icons.arrow_back, color: _colorTween.value,)),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },

      ),

      actions: [



        IconButton(
            onPressed: () {},
            icon: _makeIcon(Icons.share),),
        IconButton(
            onPressed: () {},
            icon: _makeIcon(Icons.more_vert),),
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
      controller: _controller
      ,slivers: [
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // 제목 금액 좌측 정렬용
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 120,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "상품 제목",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "금액",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size?.width,
      height: 55,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if (isMyFavoriteContent) {
                await contentsRepository.deleteMyFavoriteContent(widget.data["cid"] as String);
              } else {
                await contentsRepository.addMyFavoriteContent(widget.data);
              }
              setState(() {
                isMyFavoriteContent = !isMyFavoriteContent;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar( //scaffoldKey FO에 따라 코드 변경
                duration: Duration(milliseconds: 1000),
                content: Text(
                    isMyFavoriteContent ? "관심목록에 추가됐어요." : "관심목록에서 제거됐어요."),
              ));
            },
            child: SvgPicture.asset(
              isMyFavoriteContent
                  ? "assets/svg/heart_on.svg"
                  : "assets/svg/heart_off.svg",
              width: 20,
              height: 20,
              color: Color(0xfff08f4f),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            width: 1,
            height: 40,
            color: Colors.black.withOpacity(0.3),
          ),
          Column(
            children: [
              Text(
                widget.data["price"]!,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "가격 제안 불가",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
          Expanded(
              child: Row(
                // 컨텐츠 영역 만큼 잡히게 됨
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xfff08f4f),), // 색깔은 Decoration 안에 넣어야 함
                child: Text(
                  "채팅으로 거래하기",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ))
        ],
      ),
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
