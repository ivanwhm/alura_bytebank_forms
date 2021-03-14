class Transfer {
  final double value;
  final String targetAccount;

  Transfer(
    this.value,
    this.targetAccount,
  );

  String toStringValue() => 'R\$ $value';

  String toStringTargetAccount() => targetAccount;
}
