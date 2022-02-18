import 'package:ecommerce/widgets/text_button.dart';
import 'package:flutter/material.dart';

Future defaultDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required VoidCallback ok,
}) async {
  return showDialog(
      context: context,
      builder: (contextx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                'https://th.bing.com/th/id/R.e94b0bb00b08ae3e35d92874f39ec09e?rik=hhKs%2b1D1VQg2NQ&pid=ImgRaw&r=0',
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 10),
              Text(
                title,
              ),
            ],
          ),
          content: Text(
            subTitle,
          ),
          contentPadding: const EdgeInsets.all(20),
          actions: [
            defaultTextButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
              textStyle: const TextStyle(color: Colors.red),
            ),
            defaultTextButton(
              text: 'Ok',
              onPressed: ok,
              textStyle: const TextStyle(color: Colors.red),
            ),
          ],
        );
      });
}
