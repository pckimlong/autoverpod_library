import 'import_resolution_types.dart';

class ImportResolutionState {
  const ImportResolutionState({
    required this.orgId,
    required this.customerId,
    required this.channel,
    required this.note,
  });

  final OrgId orgId;
  final CustomerId customerId;
  final PaymentChannel channel;
  final String note;

  factory ImportResolutionState.initial() {
    return ImportResolutionState(
      orgId: OrgId.fromValue('org-1'),
      customerId: CustomerId.fromValue('customer-1'),
      channel: PaymentChannel.cash,
      note: '',
    );
  }

  ImportResolutionState copyWith({
    OrgId? orgId,
    CustomerId? customerId,
    PaymentChannel? channel,
    String? note,
  }) {
    return ImportResolutionState(
      orgId: orgId ?? this.orgId,
      customerId: customerId ?? this.customerId,
      channel: channel ?? this.channel,
      note: note ?? this.note,
    );
  }
}
