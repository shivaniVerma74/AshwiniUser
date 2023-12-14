import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:eshop_multivendor/Helper/Session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpiPaymentClass {
  String amount;
  BuildContext context;
  ValueChanged onResult;
  UpiPaymentClass(this.amount, this.context, this.onResult);

  void init() async {
    try {
      final res =
      await EasyUpiPaymentPlatform.instance.startPayment(
        EasyUpiPaymentModel(
          payeeVpa: 'eazypay.ntb1100045452@icici',
          payeeName: 'Praveen Paliwal',
          amount: double.parse(amount.toString()),
          description: 'Testing payment',
        ),
      );
      // TODO: add your success logic here
      print("new response here ${res}");
      if (res != null) {
        onResult(res.transactionId);
        /*  showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 54,
            ),
            content: Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Txn Id:'),
                    ),
                    Text('  ${res!.transactionId}  '),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Response Code:'),
                    ),
                    Text('  ${res!.responseCode}  '),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Ref No:'),
                    ),
                    Text('  ${res!.approvalRefNo}  '),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Txn Ref Id:'),
                    ),
                    Text('  ${res!.transactionRefId}  '),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Amount :'),
                    ),
                    Text('  ${res!.amount}  '),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onResult(res.transactionId);
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );*/
        print("ssss response code here  ${res} andc ${res.responseCode}");
        print(res!.responseCode);
        print(res!.transactionId);
        print(res!.transactionRefId);
      } else {
        Fluttertoast.showToast(msg: "Payment cancelled and failed");
      }
    } on EasyUpiPaymentException {
//    TODO: add your exception logic here
      Fluttertoast.showToast(msg: "Payment cancelled and failed");
     ;
    }
  }
}
