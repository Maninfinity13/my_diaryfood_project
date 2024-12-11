// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'dart:io' show Platform, exit;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_diaryfood_project/models/diaryfood.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/services/call_api.dart';
import 'package:my_diaryfood_project/utils/env.dart';
import 'package:my_diaryfood_project/views/insert_diaryfood_ui.dart';
import 'package:my_diaryfood_project/views/up_del_diaryfood_ui.dart';
import 'package:my_diaryfood_project/views/update_profile_ui.dart';

class HomeUI extends StatefulWidget {
  //สร้างตัวแปรประเภท member มารับ
  Member? member;

  HomeUI({super.key, this.member});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //ตัวแปรเก็บข้อมูลบันทึกการกินที่ได้จากการเรียกใช้ API
  Future<List<Diaryfood>>? diaryfoodData;

  //สร้างเมธอดที่เรียกใช้งานเมธอดที่เรียก API ที่ CallAPI
  getAllDiaryFoodByMember(Diaryfood diaryfood) {
    setState(() {
      diaryfoodData = CallAPI.callGetAllDiaryFoodByMember(diaryfood);
    });
  }

  @override
  void initState() {
    //สร้างตัวแปรเก็บข้อมูลที่จะส่งไปตอนเรียกใช้ API
    Diaryfood diaryfood = Diaryfood(
      memId: widget.member!.memId,
    );
    //เรียกใช้ API เพื่อดึงข้อมูลบันทึกการกิน
    getAllDiaryFoodByMember(diaryfood);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'บันทึกการกิน',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pop(context); หรือ
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.045,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                '${Env.hostName}/mydiaryfood/picupload/member/${widget.member!.memImage}',
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Text(
              'ชื่อ-สกุล: ${widget.member!.memFullname!}',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'อีเมล์: ${widget.member!.memEmail!}',
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfileUI(member: widget.member),
                  ),
                ).then((value) {
                  //ตรวจสอบก่อนว่าเมื่อย้อนกลับมาหน้านี้มีการส่งข้อมูลมาด้วยหรือไม่
                  if (value != null) {
                    //เอาค่าที่ส่งกลับมาหลังจากแก้ไขเสร็จมาแก้ให้กับ widget.member
                    setState(() {
                      widget.member?.memEmail = value.memEmail;
                      widget.member?.memUsername = value.memUsername;
                      widget.member?.memPassword = value.memPassword;
                      widget.member?.memAge = value.memAge;
                    });
                  }
                });
              },
              child: Text(
                '(UPDATE PROFILE)',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Diaryfood>>(
                  future: diaryfoodData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data![0].message == "0") {
                        return Text("ยังไม่มีพบข้อมูล");
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpDelDiaryfoodUI(
                                          diaryfood: snapshot.data![index],
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(() {
                                        Diaryfood diaryfood = Diaryfood(
                                          memId: widget.member!.memId,
                                        );
                                        getAllDiaryFoodByMember(diaryfood);
                                      });
                                    });
                                  },
                                  tileColor: index % 2 == 0 ? Colors.red[50] : Colors.green[50],
                                  leading: ClipRRect(
                                    child: Image.network(
                                      '${Env.hostName}/mydiaryfood/picupload/food/${snapshot.data![index].foodImage}',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data![index].foodShopname!,
                                  ),
                                  subtitle: Text(
                                    'วันที่บันทึก: ${snapshot.data![index].foodDate!}',
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.green[800],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertDiaryfoodUI(
                memId: widget.member!.memId!,
              ),
            ),
          ).then((value) {
            setState(() {
              Diaryfood diaryfood = Diaryfood(
                memId: widget.member!.memId,
              );
              getAllDiaryFoodByMember(diaryfood);
            });
          });
        },
        // child: Icon(
        //   Icons.add,
        //   color: Colors.white,
        // ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          'เพิ่มการกิน',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
