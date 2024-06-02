class Tender {
  final String id;
  final String method;
  final String tenderId;
  final String nameOfWork;
  final String department;
  final String location;
  final String lastDate;
  final String docPrice;
  final String tenderSecurity;
  final String liquid;
  final String similar;
  final String turnover;
  final String tenderCapacity;
  final String others;
  final String tenderLastDate;

  Tender({
    required this.id,
    required this.method,
    required this.tenderId,
    required this.nameOfWork,
    required this.department,
    required this.location,
    required this.lastDate,
    required this.docPrice,
    required this.tenderSecurity,
    required this.liquid,
    required this.similar,
    required this.turnover,
    required this.tenderCapacity,
    required this.others,
    required this.tenderLastDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'method': method,
      'tenderId': tenderId,
      'nameOfWork': nameOfWork,
      'department': department,
      'location': location,
      'lastDate': lastDate,
      'docPrice': docPrice,
      'tenderSecurity': tenderSecurity,
      'liquid': liquid,
      'similar': similar,
      'turnover': turnover,
      'tenderCapacity': tenderCapacity,
      'others': others,
      'tenderLastDate': tenderLastDate,
    };
  }

  factory Tender.fromMap(Map<String, dynamic> map) {
    return Tender(
      id: map['id'] ?? '',
      method: map['method'] ?? '',
      tenderId: map['tenderId'] ?? '',
      nameOfWork: map['nameOfWork'] ?? '',
      department: map['department'] ?? '',
      location: map['location'] ?? '',
      lastDate: map['lastDate'] ?? '',
      docPrice: map['docPrice'] ?? '',
      tenderSecurity: map['tenderSecurity'] ?? '',
      liquid: map['liquid'] ?? '',
      similar: map['similar'] ?? '',
      turnover: map['turnover'] ?? '',
      tenderCapacity: map['tenderCapacity'] ?? '',
      others: map['others'] ?? '',
      tenderLastDate: map['tenderLastDate'] ?? '',
    );
  }
}
