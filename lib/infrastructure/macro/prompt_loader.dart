// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:toml/toml.dart';

class AiTextConvertPromptProfile {
  final String model;
  final String prompt;

  AiTextConvertPromptProfile({required this.model, required this.prompt});

  static Future<AiTextConvertPromptProfile> createAiTextConvertPrompt(
    String order,
    String input,
  ) async {
    final String tomlString = await rootBundle.loadString(
      'assets/prompts/ai_text_convert_prompt.toml',
    );

    final Map<String, dynamic> promptConfig =
        TomlDocument.parse(tomlString).toMap();

    final model = promptConfig['model'] as String;
    final basicPrompt = promptConfig['prompt'] as String;

    final prompt = basicPrompt
        .replaceAll("{{order}}", order)
        .replaceAll("{{input}}", input);

    return AiTextConvertPromptProfile(model: model, prompt: prompt);
  }
}
