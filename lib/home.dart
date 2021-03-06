import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_mock_app/main.dart';
import 'package:upi_mock_app/services/getImage.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String imgurl = "";
  late CameraController controller;
  late Future<void> initializeController;
  CameraDescription camera = cameras[0];
  final String fallback =
      "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";

  void initCameraController() {
    controller = CameraController(camera, ResolutionPreset.max);
    initializeController = controller.initialize();
  }

  void initImageUrl() async {
    String temp = await GetImage().getImageFromApi();
    setState(() {
      imgurl = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    initImageUrl();
    initCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "Savings",
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    child: Text(
                      "Pay through UPI",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter UPI Number",
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FutureBuilder(
                    future: initializeController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black,
                              child: CameraPreview(controller),
                            ),
                            Positioned.fill(
                              top: -100.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: Duration(
                                    milliseconds: 2500,
                                  ),
                                  height: 200.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 5.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.23,
            minChildSize: 0.23,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 3.0)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: 3,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Search Contact",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    if (index == 1) {
                      return Padding(
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.contacts_rounded),
                            hintText: "Select Number",
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          onTap: () => {print("hello")},
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              imgurl == '' ? fallback : imgurl,
                              scale: 0.2,
                            ),
                          ),
                          title: Text("Contact name"),
                          subtitle: Text("the phone number"),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }
}
