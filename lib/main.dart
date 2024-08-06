import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Printing Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: printInvoice,
            child: Text('Print Document'),
          ),
        ),
      ),
    );
  }

  void _printDocument() async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello World'),
        ); // Center
      },
    )); // Page

    // Print the document
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  Future<pw.Font> loadFont() async {
    final fontData = await rootBundle.load(' assets/fonts/Cairo/Cairo.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<void> printInvoice() async {
    final pdf = pw.Document();
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Hacen_Tunisia.ttf"),
    ); // Ensure the font supports Arabic characters
    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: arabicFont),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('فاتورة مبيعات رقم 1324',
                  style: pw.TextStyle(fontSize: 20, font: arabicFont)),
              pw.SizedBox(height: 10),
              pw.Text('شركة الاخلاص للتجارة و التوزيع',
                  style: pw.TextStyle(fontSize: 18, font: arabicFont)),
              pw.SizedBox(height: 10),
              pw.Text('اسم العميل: محمد زغلول السباك',
                  style: pw.TextStyle(font: arabicFont)),
              pw.Text('العنوان: قويسنا ش-مصطفي فهمى بجوار مسجد الزاوية',
                  style: pw.TextStyle(font: arabicFont)),
              pw.Text('التليفون: 01008226425-01000927095',
                  style: pw.TextStyle(font: arabicFont)),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>[
                    'الكود',
                    'اسم الصنف',
                    'الكمية',
                    'سعر الوحدة',
                    'الجمالية'
                  ],
                  <String>[
                    '1131',
                    'مواسير 32/3 مم pvc جولدن هاوس',
                    '3 متر',
                    '53',
                    '135.15'
                  ],
                  <String>[
                    '1170',
                    'كوع 87.5 درجة 32 مم جولدن هاوس',
                    '1 قطعة',
                    '15.25',
                    '12.96'
                  ],
                  <String>[
                    '1145',
                    'كوع 45 درجة 32 مم جولدن هاوس',
                    '2 قطعة',
                    '16.50',
                    '28.05'
                  ],
                  <String>[
                    '1176',
                    'مشترك 45 درجة 32 مم جولدن هاوس',
                    '1 قطعة',
                    '25',
                    '21.25'
                  ],
                  <String>[
                    '1139',
                    'جلبة 32 مم جولدن هاوس',
                    '4 متر',
                    '13.75',
                    '52.25'
                  ],
                ],
                headerStyle: pw.TextStyle(font: arabicFont),
                cellStyle: pw.TextStyle(font: arabicFont),
              ),
              pw.SizedBox(height: 20),
              pw.Text('إجمالى الفاتورة: 249.66',
                  style: pw.TextStyle(font: arabicFont)),
              pw.Text('اجمالى الحساب: 27531.53',
                  style: pw.TextStyle(font: arabicFont)),
              pw.Text('الموقع: www.pioneers-solutions.com',
                  style: pw.TextStyle(font: arabicFont)),
              pw.Text('البريد الإلكتروني: mohammedemad557@yahoo.com',
                  style: pw.TextStyle(font: arabicFont)),
            ],
          );
        },
        textDirection: pw.TextDirection.rtl,
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
