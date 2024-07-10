import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final String orderId;

  const OrderDetail({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
