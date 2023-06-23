import 'package:flutter/material.dart';
import 'package:bipres/shared/theme.dart';

Widget loadingWidget(context, loading) => Center(
      child: loading
          ? Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              color: whiteColorTrans,
              child: Center(
                child: CircularProgressIndicator(),
              ))
          : null,
    );
