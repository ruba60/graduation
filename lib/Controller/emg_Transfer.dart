// var headers = {
//   'sessionKey': 'IjY2MmI2NTk3NjM4ZjIi',
//   'token': 'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
// };
// var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/patient/transfer'));
// request.fields.addAll({
// 'patient_id': '13',
// 'tr_department': '13'
// });
//
// request.headers.addAll(headers);
//
// http.StreamedResponse response = await request.send();
//
// if (response.statusCode == 200) {
// print(await response.stream.bytesToString());
// }
// else {
// print(response.reasonPhrase);
// }
