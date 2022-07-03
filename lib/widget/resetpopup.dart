import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:one/db/category/transaction/transaction_db.dart';
import 'package:one/screen/splashscreen/splash.dart';

Dialog dialogShow(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: dialogContent(
      context,
    ),
  );
}

dialogContent(
  BuildContext context,
) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 80,
          bottom: 16,
          left: 16,
          right: 16,
        ),
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Reset',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Do you want to clear all data?..',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        //   fontFamily: 'redhat'
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextButton(
                    onPressed: (() async {
                      await TransactionDB.instance.resetTransactrion();
                      Navigator.of(context).pop();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (route) => false);
                    }),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        // fontFamily: 'redhat'
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 45,
            child: Lottie.asset('asset/lottie/reset.json', height: 50),
          ),
        ],
      ),
    ],
  );
}
