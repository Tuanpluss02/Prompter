enum ModelType { textToText, textToImage }

enum GenerativeAiModel {
  midjourney('Jovie/Midjourney', 'Midjourney', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Midjourney_Emblem.png/768px-Midjourney_Emblem.png', ModelType.textToImage),
  stableDiffusion(
      'stabilityai/stable-diffusion-3.5-large', 'Stable Diffusion', 'https://images.prismic.io/encord/Zeb6euXgT-BdbvJy_image-47-.png?auto=format%2Ccompress&fit=max', ModelType.textToImage),
  flux('black-forest-labs/FLUX.1-dev', 'FLUX', 'https://www.blackforestlabs.ai/wp-content/uploads/2024/07/logo-with-text_more-1024x970.png', ModelType.textToImage),
  gemini('Gemini', 'Gemini', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThr7qrIazsvZwJuw-uZCtLzIjaAyVW_ZrlEQ&s', ModelType.textToText);

  final String modelId;
  final String displayName;
  final String avatarUrl;
  final ModelType modelType;

  const GenerativeAiModel(this.modelId, this.displayName, this.avatarUrl, this.modelType);
}
