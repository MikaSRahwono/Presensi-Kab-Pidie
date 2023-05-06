import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:presensi_mobileapp/features/authentication/data/model/http_exception_model.dart';
import 'package:presensi_mobileapp/features/history/data/model/_model.dart';
import 'package:presensi_mobileapp/features/history/presentation/pages/_pages.dart';
import 'package:presensi_mobileapp/widgets/_widgets.dart';

import '../../../presensi/data/model/_model.dart';
import '../../data/model/_model.dart';
import '../../data/model/user_model.dart';
import '../pages/_pages.dart';

part 'user_provider.dart';
