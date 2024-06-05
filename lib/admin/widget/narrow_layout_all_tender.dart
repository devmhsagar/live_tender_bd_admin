import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';

class NarrowLayout extends StatelessWidget {
  final List<Tender> tenders;
  final Function(String) onDelete;

  NarrowLayout({required this.tenders, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tenders.length,
      itemBuilder: (context, index) {
        Tender tender = tenders[index];
        return Card(
          child: ListTile(
            title: Text(tender.tenderId),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tender.nameOfWork,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(tender.department),
                Text(tender.method),
                Text(tender.location),
                Text(tender.lastDate),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Implement edit functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDelete(tender.tenderId);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Implement view functionality
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
