class Monitor {
  int? monitorId;
  int? fkSite;
  String? volt1;
  String? volt2;
  String? volt3;
  String? volt4;
  String? volt5;
  String? volt6;
  String? curr1;
  String? curr2;
  String? curr3;
  String? currAirCon;
  String? pressure;
  String? temperature;
  String? dateTime;

  Monitor(
      {this.monitorId,
      this.fkSite,
      this.volt1,
      this.volt2,
      this.volt3,
      this.volt4,
      this.volt5,
      this.volt6,
      this.curr1,
      this.curr2,
      this.curr3,
      this.currAirCon,
      this.dateTime,
      this.pressure,
      this.temperature});

  Monitor.fromJson(Map<String, dynamic> json) {
    monitorId = json['id_monitor'];
    fkSite = json['fk_site'];
    temperature = json['temperature'];
    pressure = json['pressure'];
    volt1 = json['voltage1'];
    volt2 = json['voltage2'];
    volt3 = json['voltage3'];
    volt4 = json['voltage4'];
    volt5 = json['voltage5'];
    volt6 = json['voltage6'];
    curr1 = json['current1'];
    curr2 = json['current2'];
    curr3 = json['current3'];
    currAirCon = json['currentAirCon'];
    dateTime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_monitor'] = this.monitorId;
    data['fk_site'] = this.fkSite;
    data['voltage1'] = this.volt1;
    data['voltage2'] = this.volt2;
    data['voltage3'] = this.volt3;
    data['voltage4'] = this.volt4;
    data['voltage5'] = this.volt5;
    data['voltage6'] = this.volt6;
    data['current1'] = this.curr1;
    data['current2'] = this.curr2;
    data['current3'] = this.curr3;
    data['currentAirCon'] = this.currAirCon;
    data['pressure'] = this.pressure;
    data['temperature'] = this.temperature;
    data['datetime'] = this.dateTime;
    return data;
  }
}
