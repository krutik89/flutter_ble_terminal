class BluetoothSchema {
  // late int id;
  late String remoteId;
  late String messages;

  BluetoothSchema({required this.remoteId, required this.messages});

  BluetoothSchema.fromMap(Map<String, dynamic> item)
      :
        // : id = item["id"],
        remoteId = item["remoteId"],
        messages = item["messages"];

  Map<String, Object> toMap() {
    return {'remoteId': remoteId, 'messages': messages};
  }
}
