enum FilterType {
  brand,
  model,
  generation,
  modification,
  year,
  mileage,
  currency,
  price,
  bodyType,
  service,
  fuel,
  transmission,
  color,
  numberOfOwners,
  externalBodyKit,
  optics,
  salon,
  media,
  carOptions,
  configurations,
  description,
  time24,
  timeFrom,
  timeTo,
  replacedParts,
  photography,
  none,
  region,
  contact,
  status
}

enum Tables {
  grade,
  phrase,
  principle,
  word;

  String get text => switch (this) {
        Tables.grade => 'grade',
        Tables.phrase => 'phrase',
        Tables.principle => 'principle',
        Tables.word => 'word',
      };
}

enum PaymentType {
  cash,
  cashUSD,
  card,
  cardTerminal,
  debit;

  String get text => switch (this) {
        PaymentType.card => 'Kartaga',
        PaymentType.cardTerminal => 'Terminaldan',
        PaymentType.cash => "So'mda",
        PaymentType.cashUSD => 'Dollarda',
        PaymentType.debit => 'Qarzga',
      };
}
