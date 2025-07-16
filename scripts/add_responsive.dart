import 'dart:io';

void main() async {
  // تحديد المسار الخاص بالمشروع
  final projectDir =
      r'D:\final_result_project_ypu\final_project_ypu'; // تأكد من تحديث المسار بشكل صحيح

  // اقرأ جميع ملفات Dart في المجلد
  final dartFiles = Directory(projectDir).listSync(recursive: true).where((
    file,
  ) {
    return file.path.endsWith('.dart');
  });

  // كل ملف Dart سيتم مراجعته
  for (var file in dartFiles) {
    if (file is File) {
      String content = await file.readAsString();

      // إضافة .sp إلى Text
      content = content.replaceAllMapped(RegExp(r'fontSize:\s*(\d+)'), (match) {
        return 'fontSize: ${match.group(1)}.sp';
      });

      // إضافة .h إلى SizedBox, Padding
      content = content.replaceAllMapped(RegExp(r'height:\s*(\d+)'), (match) {
        return 'height: ${match.group(1)}.h';
      });
      content = content.replaceAllMapped(RegExp(r'width:\s*(\d+)'), (match) {
        return 'width: ${match.group(1)}.w';
      });

      // إعادة الكتابة في الملف بعد التعديل
      await file.writeAsString(content);
      print('Updated file: ${file.path}');
    }
  }

  print('All files processed.');
}
