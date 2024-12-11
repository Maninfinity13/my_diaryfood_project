//call_api.dart
//ไฟล์นี้จะประกอบเมธอดต่างๆ ที่ใช้เรียก  API ต่างๆ ตามวัตถุประสงค์การทำงานของ App
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:my_diaryfood_project/models/diaryfood.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:http/http.dart' as http;
import 'package:my_diaryfood_project/utils/env.dart';

class CallAPI {
  //เมธอดเรียก API ตรวจสอบชื่อผู้ใช้รหัสผ่าน --------------------------
  static Future<Member> callCheckLoginAPI(Member member) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/check_login_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Member.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API บันทึกเพิ่มข้อมูลสมาชิกใหม่ --------------------------
  static Future<Member> callRegisterMemberAPI(Member member) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/register_member_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Member.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API แก้ไขข้อมูลผู้ใช้งาน -----------------------------
  static Future<Member> callUpdateMemberAPI(Member member) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/update_member_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Member.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API ดึงข้อมูลการกินของ member คนนั้นๆ
  static Future<List<Diaryfood>> callGetAllDiaryFoodByMember(Diaryfood diaryfood) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/get_all_diaryfood_by_member_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(diaryfood.toJson()),
    );

    if (responseData.statusCode == 200) {
      final dataList = await jsonDecode(responseData.body).map<Diaryfood>((json) {
        return Diaryfood.fromJson(json);
      }).toList();

      return dataList;
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API บันทึกเพิ่มข้อมูลบันทึกการกิน --------------------------
  static Future<Diaryfood> callInsertDiaryfoodAPI(Diaryfood diaryfood) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/insert_diaryfood_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(diaryfood.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Diaryfood.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API บันทึกแก้ไขข้อมูลบันทึกการกิน --------------------------
  static Future<Diaryfood> callUpdateDiaryfoodAPI(Diaryfood diaryfood) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/update_diaryfood_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(diaryfood.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Diaryfood.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API บันทึกลบข้อมูลบันทึกการกิน --------------------------
  static Future<Diaryfood> callDeleteDiaryfoodAPI(Diaryfood diaryfood) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/delete_diaryfood_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(diaryfood.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Diaryfood.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }
}
