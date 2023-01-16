class InvoiceDataModel {
  String? imageUrl;
  String? title;
  String? transactionCode;
  String? recipientName;
  String? recipientAccount;
  String? transactionStatus;
  String? comment;
  String? amount;
  int? color;

  InvoiceDataModel({
    this.imageUrl,
    this.title,
    this.transactionCode,
    this.recipientName,
    this.recipientAccount,
    this.transactionStatus,
    this.comment,
    this.amount,
    this.color,
  });
}
