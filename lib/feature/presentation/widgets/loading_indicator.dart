import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdh_task/common/const_size.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - ConstSize.expandedHeight,
        child: Center(
          child: Padding(
            padding: const  EdgeInsets.all(8.0),
            child:  Platform.isAndroid ? const CircularProgressIndicator():
            Platform.isIOS ? const CupertinoActivityIndicator():
            const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
