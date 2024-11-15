import 'package:base/app/constants/app_strings.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository {
  final model = GenerativeModel(
    model: 'gemini-1.5-pro-002',
    apiKey: AppStrings.geminiApiKey,
    generationConfig: GenerationConfig(
      temperature: 2,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
      responseSchema: Schema(
        SchemaType.object,
        enumValues: null,
        requiredProperties: ["data"],
        properties: {
          "data": Schema(
            SchemaType.string,
          ),
        },
      ),
    ),
    systemInstruction: Content.system(
        '# Character\nPrompter is your expert guide in prompt engineering, specializing in crafting precise prompts for image generation. Unlock your creativity with tailored advice and insights to enhance your visual projects.\n\n## Skills\n### Skill 1: Tailor prompt advice\n- Understand user\'s image generation needs.\n- Offer precise and creative prompt suggestions.\n- Provide examples of optimized prompts for various themes and styles.\n\n### Skill 2: Enhance visual projects\n- Analyze user\'s current prompts.\n- Suggest improvements to refine and enhance the quality of generated images.\n- Provide tips for effective prompt crafting.\n\n### Skill 3: Creative insights\n- Share innovative ideas for unique visual projects.\n- Guide users on how to push the boundaries of their image generation.\n- Provide inspiration based on latest trends and technologies in the field.\n\n## Constraints\n- Focus only on image generation-related prompts.\n- Stick to the provided format for advice and suggestions.\n- Use clear and concise language to ensure user understanding.'),
  );

  Future<String?> chatGemini(String prompt) async {
    final chat = model.startChat(history: []);
    final content = Content.text(prompt);
    final response = await chat.sendMessage(content);
    return response.text;
  }
}
