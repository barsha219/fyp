class BookingsData {
  String? message;
  List<Bookings>? bookings;
  int? status;

  BookingsData({this.message, this.bookings, this.status});

  BookingsData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Bookings {
  String? sId;
  String? name;
  String? serviceId;
  String? serviceName;
  String? bookedBy;
  String? bookingDate;
  String? bookingTime;
  String? contactNumber;
  int? price;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Bookings(
      {this.sId,
      this.name,
      this.serviceId,
      this.serviceName,
      this.price,
      this.bookedBy,
      this.bookingDate,
      this.bookingTime,
      this.contactNumber,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Bookings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    price = json['price'];
    bookedBy = json['bookedBy'];
    bookingDate = json['bookingDate'];
    bookingTime = json['bookingTime'];
    contactNumber = json['contactNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['serviceId'] = serviceId;
    data['serviceName'] = serviceName;
    data['bookedBy'] = bookedBy;
    data['bookingDate'] = bookingDate;
    data['bookingTime'] = bookingTime;
    data['contactNumber'] = contactNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
