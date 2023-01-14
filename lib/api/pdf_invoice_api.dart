import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:receipt/api/pdf_api.dart';

import '../utils.dart';

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = Document();

    Uint8List logoImage =
        (await rootBundle.load('assets/images/one.png')).buffer.asUint8List();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildTitle(logoImage),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildHeader(),
        SizedBox(height: 1 * PdfPageFormat.cm),
        Divider(),
        SizedBox(height: 1 * PdfPageFormat.cm),
        Center(
          child: Text(
            "Transfer slip",
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
        SizedBox(height: 1 * PdfPageFormat.cm),
        mainContent(),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: 'receipt.pdf', pdf: pdf);
  }

// Done
  static buildTitle(Uint8List logoImage) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pw.Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
              height: 72,
              child: pw.Image(
                pw.RawImage(bytes: logoImage, height: 50, width: 50),
              ),
            ),
            Text(
              'OneCash One Microfinance ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const PdfColor.fromInt(0xff694b9e),
              ),
            ),
            SizedBox(height: 0.2 * PdfPageFormat.cm),
          ],
        ),
      );
// Done
  static Widget buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 235,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Transaction Code:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text("ASWE12685WHjii90"),
                  ],
                ),
              ),
              Container(
                width: 160,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Transaction Date:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(Utils.formatDate(DateTime.now())),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  static Widget mainContent() => Column(
        children: [
          buildMainContent("Recipient Name: ", "Ashenafi Mohammed"),
          SizedBox(height: 2.5 * PdfPageFormat.mm),
          buildMainContent("Recipient Account: ", "1000124578963"),
          SizedBox(height: 2.5 * PdfPageFormat.mm),
          buildMainContent("Comment: ", "have my money"),
          SizedBox(height: 2.5 * PdfPageFormat.mm),
          buildMainContent("Transaction Status: ", "Processed".toUpperCase()),
          SizedBox(height: 2.5 * PdfPageFormat.mm),
          buildMainContent("Amount: ", "50,000 birr"),
          SizedBox(height: 2.5 * PdfPageFormat.mm),
        ],
      );
  static pw.Center buildMainContent(String title, String value) {
    return Center(
        child: Container(
      width: 320.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    ));
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Powered by'),
        ],
      );

  static buildSimpleText({
    required String title,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        RichText(
          text: TextSpan(
            text: 'Bel',
            style: TextStyle(
              color: PdfColors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'Cash',
                style: TextStyle(
                  color: const PdfColor.fromInt(0xfffe9520),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 2 * PdfPageFormat.mm),
      ],
    );
  }
}
