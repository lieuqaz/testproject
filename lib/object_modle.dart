class ObjectModel {
  String? result;
  String? typekr;
  String? criteria;
  String? start;
  String? target;
  String? unit;
  String? date;
  ObjectModel(
      {this.result,
      this.typekr,
      this.criteria,
      this.start,
      this.target,
      this.unit,
      this.date});
  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
        result: json['result'],
        typekr: json['typekr'],
        criteria: json['criteria'],
        start: json['start'],
        target: json['target'],
        unit: json['unit'],
        date: json['date']);
  }
  Map<String, dynamic> toJson() => { 'result': result,
        'typekr': typekr,
        'criteria': criteria,
        'start': start,
        'target': target,
        'unit': unit,
        'date':date};
}
