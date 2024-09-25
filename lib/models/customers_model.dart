// To parse this JSON data, do
//
//     final customersModel = customersModelFromMap(jsonString);

import 'dart:convert';

CustomersModel customersModelFromMap(String str) => CustomersModel.fromMap(json.decode(str));

String customersModelToMap(CustomersModel data) => json.encode(data.toMap());

class CustomersModel {
    bool? error;
    String? message;
    List<Customer>? customer;

    CustomersModel({
        this.error,
        this.message,
        this.customer,
    });

    factory CustomersModel.fromMap(Map<String, dynamic> json) => CustomersModel(
        error: json["error"],
        message: json["message"],
        customer: json["customer"] == null ? [] : List<Customer>.from(json["customer"]!.map((x) => Customer.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "customer": customer == null ? [] : List<dynamic>.from(customer!.map((x) => x.toMap())),
    };
}

class Customer {
    String? id;
    String? name;
    String? address;
    String? phone;
    List<Glass>? glasses;

    Customer({
        this.id,
        this.name,
        this.address,
        this.phone,
        this.glasses,
    });

    factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        glasses: json["glasses"] == null ? [] : List<Glass>.from(json["glasses"]!.map((x) => Glass.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "glasses": glasses == null ? [] : List<dynamic>.from(glasses!.map((x) => x.toMap())),
    };
}

class Glass {
    String? id;
    String? frame;
    String? lensType;
    String? left;
    String? right;
    int? price;
    int? deposit;
    String? orderDate;
    String? deliveryDate;
    String? paymentStatus;
    String? paymentMethod;
    String? customerId;
    List<Installment>? installments;

    Glass({
        this.id,
        this.frame,
        this.lensType,
        this.left,
        this.right,
        this.price,
        this.deposit,
        this.orderDate,
        this.deliveryDate,
        this.paymentStatus,
        this.paymentMethod,
        this.customerId,
        this.installments,
    });

    factory Glass.fromMap(Map<String, dynamic> json) => Glass(
        id: json["id"],
        frame: json["frame"],
        lensType: json["lensType"],
        left: json["left"],
        right: json["right"],
        price: json["price"],
        deposit: json["deposit"],
        orderDate: json["orderDate"],
        deliveryDate: json["deliveryDate"],
        paymentStatus: json["paymentStatus"],
        paymentMethod: json["paymentMethod"],
        customerId: json["customerId"],
        installments: json["installments"] == null ? [] : List<Installment>.from(json["installments"]!.map((x) => Installment.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "frame": frame,
        "lensType": lensType,
        "left": left,
        "right": right,
        "price": price,
        "deposit": deposit,
        "orderDate": orderDate,
        "deliveryDate": deliveryDate,
        "paymentStatus": paymentStatus,
        "paymentMethod": paymentMethod,
        "customerId": customerId,
        "installments": installments == null ? [] : List<dynamic>.from(installments!.map((x) => x.toMap())),
    };
}

class Installment {
    String? id;
    String? paidDate;
    int? amount;
    int? total;
    int? remaining;
    String? glassId;

    Installment({
        this.id,
        this.paidDate,
        this.amount,
        this.total,
        this.remaining,
        this.glassId,
    });

    factory Installment.fromMap(Map<String, dynamic> json) => Installment(
        id: json["id"],
        paidDate: json["paidDate"],
        amount: json["amount"],
        total: json["total"],
        remaining: json["remaining"],
        glassId: json["glassId"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "paidDate": paidDate,
        "amount": amount,
        "total": total,
        "remaining": remaining,
        "glassId": glassId,
    };
}
