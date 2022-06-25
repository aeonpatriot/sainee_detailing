class Dashboard {
  String? totalRevenue;
  String? totalPremiumWash;
  String? totalDetailsWash;
  String? totalBasicPolish;
  String? totalUltimatePolish;
  String? totalPending;
  String? totalConfirmed;
  String? totalCompleted;
  String? totalCancelled;
  String? totalASOL;
  String? totalASCS;

  Dashboard({
    this.totalRevenue,
    this.totalPremiumWash,
    this.totalDetailsWash,
    this.totalBasicPolish,
    this.totalUltimatePolish,
    this.totalPending,
    this.totalConfirmed,
    this.totalCompleted,
    this.totalCancelled,
    this.totalASOL,
    this.totalASCS,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      totalRevenue: json['totalRevenue'],
      totalPremiumWash: json['totalPremiumWash'],
      totalDetailsWash: json['totalDetailsWash'],
      totalBasicPolish: json['totalBasicPolish'],
      totalUltimatePolish: json['totalUltimatePolish'],
      totalPending: json['totalPending'],
      totalConfirmed: json['totalConfirmed'],
      totalCompleted: json['totalCompleted'],
      totalCancelled: json['totalCancelled'],
      totalASOL: json['totalASOL'],
      totalASCS: json['totalASCS'],
    );
  }

  @override
  String toString() {
    return '''
      totalRevenue: $totalRevenue,
      totalPremiumWash: $totalPremiumWash,
      totalDetailsWash: $totalDetailsWash,
      totalBasicPolish: $totalBasicPolish,
      totalUltimatePolish: $totalUltimatePolish,
      totalPending: $totalPending,
      totalConfirmed: $totalConfirmed,
      totalCompleted: $totalCompleted,
      totalCancelled: $totalCancelled,
      totalASOL: $totalASOL,
      totalASCS: $totalASCS,
    ''';
  }
}
