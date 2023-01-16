// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';
import '../main.dart';
import '../model/invoice_model.dart';
import '../widget/button_widget.dart';
import '../widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Invoice',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Invoice PDF',
                  onClicked: () async {
                    final invoice = InvoiceDataModel(
                      imageUrl: 'assets/images/one.png',
                      title: 'OneCash One Microfinance ',
                      transactionCode: "ASWE12685WHjii90",
                      recipientName: "Ashenafi Mohammed",
                      recipientAccount: "1000124578963",
                      comment: "have my money",
                      transactionStatus: "Processed",
                      amount: "50,000",
                    );
                    final pdfFile = await PdfInvoiceApi.generate(invoice);
                    // Share.shareFiles([pdfFile.path]);
                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
