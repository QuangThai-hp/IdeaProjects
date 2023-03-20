import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../providers/NhuCau.dart';
import '../providers/NhuCaus.dart';
import '../utils/RFWidget.dart';
import 'RFHomeScreen.dart';
import 'package:provider/provider.dart';

class ChiTietNhuCau extends StatefulWidget {
  final int? nid;

  const ChiTietNhuCau({Key? key, this.nid}) : super(key: key);

  @override
  State<ChiTietNhuCau> createState() => _ChiTietNhuCauState();
}

class _ChiTietNhuCauState extends State<ChiTietNhuCau> {
  PageController pageController = PageController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var currentIndexPage = 0;
  bool nhuCauLoaded = false;
  NhuCau? nhuCau = null;

  @override
  void initState() {
    _loadNhuCau();
    Timer.periodic(Duration(seconds: 5), (_) => {
      // print(currentIndexPage)
      setState(() {
        currentIndexPage = currentIndexPage + 1;
        if(currentIndexPage > 2)
          currentIndexPage = 0;
        pageController.animateToPage(currentIndexPage, duration: Duration(seconds: 1), curve: Curves.easeIn);
      })
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadNhuCau() async{
    if(!nhuCauLoaded){
      print(widget.nid);
      NhuCaus nhuCaus = await Provider.of<NhuCaus>(context, listen: false);

      nhuCaus.getNhuCauByNid(widget.nid!).then((value){
        setState(() {
          nhuCauLoaded = true;
          nhuCau = nhuCaus.nhuCau;
        });
        print(nhuCau?.hinhAnhs);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget() {
      return BackButton(
        color: appStore.textPrimaryColor,
        onPressed: () {
          // toasty(context, 'Back button');
          RFHomeScreen rf_home = new RFHomeScreen();
          rf_home.selectedIndex = 0;
          rf_home.launch(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin nhu cầu', style: boldTextStyle(color: appStore.textPrimaryColor)),
        backgroundColor: Colors.white,
        leading: leadingWidget()
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: context.width(),
              height: context.width() * 0.55,
              child: PageView(
                controller: pageController,
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: nhuCau?.hinhAnhs.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int index) {
                      String? urlLink = 'https://happyhomehaiphong.com/images/da-luu/no-image.png';
                      if(nhuCau != null)
                        urlLink = nhuCau?.hinhAnhs[index];
                      return
                        Slider(file: urlLink!);
                    },
                  ),
                  // Slider(file: widget.sanPham!.images![0].replaceAll("//", "https://")),
                  // Slider(file: widget.sanPham!.images![0].replaceAll("//", "https://")),
                  // Slider(file: widget.sanPham!.images![0].replaceAll("//", "https://")),
                ],
                onPageChanged: (int i) {
                  setState(() {
                    currentIndexPage = i;
                  });
                },
              ),
            ),
            8.height,
          ],
        ),
      )
    );
  }
}

class Slider extends StatelessWidget {
  final String file;

  Slider({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          child: CachedNetworkImage(
            placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
            imageUrl: file,
            fit: BoxFit.cover,
          )),
    );
  }
}