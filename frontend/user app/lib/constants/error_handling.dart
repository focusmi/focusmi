import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/constants/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch(response.statusCode){
    case 200:
      onSuccess();
      showSuccessSnackBar(
        context,
        jsonDecode(response.body)['msg']??"Action completed",
      )  ;
    break;
    case 400:
      showErrorSnackBar(
        context,
        jsonDecode(response.body)['msg']??"Something went wrong",
      )  ;
      break;
  }
}