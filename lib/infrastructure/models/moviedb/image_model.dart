class ImageModel {
  final String filePath;
  final String? langugeCode;

  ImageModel({required this.filePath, this.langugeCode});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      filePath: json['file_path'] ?? '',
      langugeCode: json[ 'iso_639_1' ]
    );
  }
}
