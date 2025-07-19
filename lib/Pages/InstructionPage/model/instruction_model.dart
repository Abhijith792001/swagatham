class InstructionModel {
  final String time;
  final bool success;
  final String token;
  final Instructions instructions;

  InstructionModel({
    required this.time,
    required this.success,
    required this.token,
    required this.instructions,
  });

  factory InstructionModel.fromJson(Map<String, dynamic> json) {
    return InstructionModel(
      time: json['time']?.toString() ?? 'Unknown',
      success: json['success'] is bool ? json['success'] as bool : false,
      token: json['Token']?.toString() ?? '',
      instructions: Instructions.fromJson(
        json['instructions'] is Map ? json['instructions'] as Map<String, dynamic> : {},
      ),
    );
  }
}

class Instructions {
  final String instructions;

  Instructions({required this.instructions});

  factory Instructions.fromJson(Map<String, dynamic> json) {
    return Instructions(
      instructions: json['instructions']?.toString() ?? '',
    );
  }
}