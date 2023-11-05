import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:localsaveimage/controller/data.dart';
import 'package:provider/provider.dart';



class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({super.key});

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker().pickImage(source: source).then((value) {
     if(value!=null)
     {
      setState(() {
        
      });
       _Img= File(value.path);
       _bytes=File(_Img!.path).readAsBytesSync();
       _savedImage=base64Encode(_bytes!);
       print("image code");
       print(_savedImage);

       Provider.of<mydata>(context,listen: false).saveData(_savedImage!);

       
     }
    
    });
  }
File? _Img;
Uint8List? _bytes;
String? _savedImage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView.builder(
        scrollBehavior: AppScrollBehavior(),
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: 2,
        itemBuilder: (context, index) {
          // double offset = pageOffset - index;

          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double pageOffset = 0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page! - index;
              }
              double gauss =
                  math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));
              return Transform.translate(
                offset: Offset(-60 * gauss * pageOffset.sign, 0),
                child: Container(
                  clipBehavior: Clip.none,
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(8, 20),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                     
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(32)),
                          child: InkWell(
                            onTap: () {
                              
                              _getImage(context,index==0?ImageSource.gallery:ImageSource.camera);
                            
                            },
                            child: Icon(
                              index==0? Icons.photo:Icons.camera,
                              size: MediaQuery.of(context).size.height*0.4,
                              
                             
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              );
            },
            
          );
        },
      ),
    );
  }
}


class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}