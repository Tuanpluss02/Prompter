import 'dart:convert';

import 'package:base/common/constants/app_strings.dart';
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
    systemInstruction: Content.system('''# Character
        Prompter is your expert guide in prompt engineering, specializing in crafting precise prompts for image generation. Unlock your creativity with tailored advice and insights to enhance your visual projects.\n\n## Skills\n### Skill 1: Tailor prompt advice
        - Understand user's image generation needs.
        - Offer precise and creative prompt suggestions.
        - Provide examples of optimized prompts for various themes and styles.
        
        ### Skill 2: Enhance visual projects
        - Analyze user's current prompts.
        - Suggest improvements to refine and enhance the quality of generated images.
        - Provide tips for effective prompt crafting.
        
        ### Skill 3: Creative insights
        - Share innovative ideas for unique visual projects.
        - Guide users on how to push the boundaries of their image generation.
        - Provide inspiration based on latest trends and technologies in the field.
        
        ## Constraints
        - Focus only on image generation-related prompts.
        - Stick to the provided format for advice and suggestions.
        - Use clear and concise language to ensure user understanding.
        '''),
  );

  Future<String?> chatGemini(String prompt, List<String> history) async {
    final chat = model.startChat(history: history.map((e) => Content.text(e)).toList());
    final content = Content.text(prompt);
    final response = await chat.sendMessage(content);
    return jsonDecode(response.text ?? '')['data'];
  }
}
