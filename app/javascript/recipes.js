document.addEventListener("DOMContentLoaded", () => {
  const stepsContainer = document.getElementById("steps-container");
  const addStepButton = document.getElementById("add-step-button");
  const removeStepButton = document.getElementById("remove-step-button");

  const recipeImagesInput = document.getElementById("recipe_images");
  const imagePreviewContainer = document.querySelector(".image-preview-container");

  if (recipeImagesInput) {
    recipeImagesInput.addEventListener("change", (event) => {
      // Remove existing preview images
      while (imagePreviewContainer.firstChild) {
        imagePreviewContainer.removeChild(imagePreviewContainer.firstChild);
      }

      // Preview newly selected images
      Array.from(event.target.files).forEach((file) => {
        const image = document.createElement("img");
        image.src = URL.createObjectURL(file);
        image.width = 100;
        image.height = 100;
        image.classList.add("preview-image");
        imagePreviewContainer.appendChild(image);
      });
    });
  }

  const setupStepImagePreview = (upload) => {
    upload.addEventListener("change", (event) => {
      const stepImagePreviewContainer = event.target.parentElement.nextElementSibling.querySelector(".step-image-preview-container");

      // Remove existing preview images
      while (stepImagePreviewContainer.firstChild) {
        stepImagePreviewContainer.removeChild(stepImagePreviewContainer.firstChild);
      }

      // Preview newly selected images
      Array.from(event.target.files).forEach((file) => {
        const image = document.createElement("img");
        image.src = URL.createObjectURL(file);
        image.width = 100;
        image.height = 100;
        image.classList.add("preview-image");
        stepImagePreviewContainer.appendChild(image);
      });
    });
  };

  // Add a new step
  addStepButton.addEventListener("click", () => {
    const newStep = document.createElement("div");
    newStep.classList.add("step");

    const stepNumber = stepsContainer.children.length + 1;

    newStep.innerHTML = `
      <h3>Step ${stepNumber}</h3>
      <div class="form-group">
        <label for="recipe_steps_attributes_${stepNumber - 1}_description">手順</label>
        <textarea class="form-control" name="recipe[steps_attributes][${stepNumber - 1}][description]" id="recipe_steps_attributes_${stepNumber - 1}_description"></textarea>
      </div>
      <div class="form-group">
        <label for="recipe_steps_attributes_${stepNumber - 1}_step_image">手順画像</label>
        <input type="file" class="form-control step-image-upload" name="recipe[steps_attributes][${stepNumber - 1}][step_image]" id="recipe_steps_attributes_${stepNumber - 1}_step_image">
      </div>
      <div class="step-image-preview">
        <h3 class="section-title">手順画像プレビュー</h3>
        <div class="step-image-preview-container"></div>
      </div>
    `;

    stepsContainer.appendChild(newStep);

    // Setup step image preview for the newly added step
    const newStepImageUpload = newStep.querySelector(".step-image-upload");
    setupStepImagePreview(newStepImageUpload);
  });

  // Remove the last step
  removeStepButton.addEventListener("click", () => {
    if (stepsContainer.children.length > 1) {
      stepsContainer.removeChild(stepsContainer.lastChild);
    }
  });

  // Setup step image preview for the initial step
  const initialStepImageUpload = document.querySelector(".step-image-upload");
  setupStepImagePreview(initialStepImageUpload);
});

