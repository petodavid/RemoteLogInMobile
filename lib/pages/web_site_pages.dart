import 'package:RemoteLogIn/pages/selected_web_site_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WebSitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("page").snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedWebSitePage(
                            page: data.id,
                          ),
                        ),
                      );
                    },
                    title: Text(data.id),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        data.get('logo'),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
