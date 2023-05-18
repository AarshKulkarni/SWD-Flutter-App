import 'package:flutter/material.dart';
import 'package:swd_app/models/req_resource.dart';

class ResDetails extends StatelessWidget {
  const ResDetails({super.key, required this.res});
  final ReqResource res;
  Color getColor(String s) {
    var color = s.toUpperCase().replaceAll("#", "0xFF");
    return Color(int.parse(color));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: 4),
      title: Text(
        res.name.toString(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Year: ${res.year}',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            width: 20,
          ),
          Text('Pantone Value: ${res.pantoneValue}',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            width: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(
                    int.parse(res.color.toUpperCase().replaceAll("#", "0xFF"))),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            height: 30,
            width: 30,
          ),
        ],
      ),
    );
  }
}
