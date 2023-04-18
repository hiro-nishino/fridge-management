function handleImagePreview(input, previewElement) {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = (e) => {
      previewElement.setAttribute("src", e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const addStepButton = document.querySelector("#add-step");
  const stepsContainer = document.querySelector("#steps-container");

  if (addStepButton) {
    addStepButton.addEventListener("click", () => {
      const stepTemplate = document.querySelector("#step-template").innerHTML;
      const stepElement = document.createElement("div");
      stepElement.innerHTML = stepTemplate.replace(/NEW_RECORD/g, new Date().getTime());
      stepsContainer.appendChild(stepElement);
    });
  }


  // レシピ画像プレビュー
  const recipeImageInput = document.querySelector("#recipe_images");
  const recipeImagePreview = document.querySelector("#recipe_image_preview");

  if (recipeImageInput) {
    recipeImageInput.addEventListener("change", () => {
      handleImagePreview(recipeImageInput, recipeImagePreview);
    });
  }

  // 手順画像プレビュー
  document.addEventListener("change", (event) => {
    if (event.target.matches(".step-image-input")) {
      const stepImagePreview = event.target.closest(".nested-fields").querySelector(".step-image-preview");
      handleImagePreview(event.target, stepImagePreview);
    }
  });
});