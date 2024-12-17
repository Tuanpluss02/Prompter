enum ModelType { textToText, textToImage }

enum GenerativeAiModel {
  midjourney('Jovie/Midjourney', 'Midjourney', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Midjourney_Emblem.png/768px-Midjourney_Emblem.png', ModelType.textToImage),
  stableDiffusion(
      'stabilityai/stable-diffusion-3.5-large', 'Stable Diffusion', 'https://images.prismic.io/encord/Zeb6euXgT-BdbvJy_image-47-.png?auto=format%2Ccompress&fit=max', ModelType.textToImage),
  flux('black-forest-labs/FLUX.1-dev', 'FLUX', 'https://tjzk.replicate.delivery/models_organizations_avatar/01ed70be-0d47-4a4a-85fb-32c02cdd4ab5/bfl.png', ModelType.textToImage),
  gemini('Gemini', 'Prompter Assistant', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThr7qrIazsvZwJuw-uZCtLzIjaAyVW_ZrlEQ&s', ModelType.textToText);

  final String modelId;
  final String displayName;
  final String avatarUrl;
  final ModelType modelType;

  const GenerativeAiModel(this.modelId, this.displayName, this.avatarUrl, this.modelType);
}
