import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'status')
enum Status {
  active('active'),
  locked('locked');

  const Status(this.status);
  final String status;
}
