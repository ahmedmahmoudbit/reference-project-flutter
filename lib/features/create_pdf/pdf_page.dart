import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'model/invoice.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';

  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('title'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: const [
                    Icon(Icons.picture_as_pdf, size: 100, color: Colors.white),
                    const SizedBox(height: 16),
                    Text(
                      'Generate Invoice',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Invoice PDF',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: createPDF,
                ),

              ],
            ),
          ),
        ),
      );

  void createPDF() async {
    // today date
    final date = DateTime.now();
    // payment terms .
    final dueDate = date.add(Duration(days: 7));

    final invoice = Invoice(
      // data client .
      supplier: Supplier(
        name: 'Sarah Field',
        address: 'Sarah Street 9, Beijing, China',
        paymentInfo: 'https://paypal.me/sarahfieldzz',
      ),
      // data supervisor.
      customer: Customer(
        name: 'Apple Inc.',
        address: 'Apple Street, Cupertino, CA 95014',
      ),

      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'My description...',
        number: '${DateTime.now().year}-9999',
      ),
      items: [
        // data table ..
        InvoiceItem(
          address: 'aaaaa',
          description: 'Coffee',
          date: DateTime.now(),
          quantity: 3,
          vat: 0.19,
          unitPrice: 5.99,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Water',
          date: DateTime.now(),
          quantity: 8,
          vat: 0.19,
          unitPrice: 0.99,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Orange',
          date: DateTime.now(),
          quantity: 3,
          vat: 0.19,
          unitPrice: 2.99,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Apple',
          date: DateTime.now(),
          quantity: 8,
          vat: 0.19,
          unitPrice: 3.99,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Mango',
          date: DateTime.now(),
          quantity: 1,
          vat: 0.19,
          unitPrice: 1.59,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Blue Berries',
          date: DateTime.now(),
          quantity: 5,
          vat: 0.19,
          unitPrice: 0.99,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          address: 'aaaaa',
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
        InvoiceItem(
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
          address: 'aaaaa',
        ),
        InvoiceItem(
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          address: 'aaaaa',
          vat: 0.19,
          unitPrice: 1.29,
        ),
      ],
    );

    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);

  }
}
