document.addEventListener("DOMContentLoaded", () => {
  // 材料の追加ボタン
  const addIngredientButton = document.createElement("button");
  addIngredientButton.textContent = "材料を追加";
  addIngredientButton.classList.add("btn", "btn-secondary", "mb-3");

  const ingredientsDiv = document.getElementById("ingredients");
  ingredientsDiv.appendChild(addIngredientButton);

  addIngredientButton.addEventListener("click", (event) => {
    event.preventDefault();

    const ingredientTemplate = `
      <div class="row mb-3 ingredient-row">
        <div class="col">
          <label>材料</label>
          <input class="form-control" type="text" name="recipe[recipe_ingredients_attributes][][name]">
        </div>
        <div class="col">
          <label>量</label>
          <input class="form-control" type="number" name="recipe[recipe_ingredients_attributes][][quantity]">
        </div>
        <div class="col">
          <label>調味料</label>
          <input class="form-check-input" type="checkbox" name="recipe[recipe_ingredients_attributes][][is_seasoning]">
        </div>
        <div class="col">
          <button class="btn btn-danger remove-ingredient">削除</button>
        </div>
      </div>
    `;
    ingredientsDiv.insertAdjacentHTML("beforeend", ingredientTemplate);
    updateRemoveIngredientButton();
  });

  // 手順の追加ボタン
  const addStepButton = document.getElementById("add-step");

  if (addStepButton) {
    addStepButton.addEventListener("click", () => {
      const steps = document.getElementById("steps");
      const stepIndex = steps.childElementCount;
      const step = document.createElement("div");

      step.classList.add("form-group", "step-row");
      step.id = `step-${stepIndex}`;
      step.innerHTML = `
        <label>手順 ${stepIndex + 1}</label>
        <textarea class="form-control" name="recipe[recipe_steps_attributes][${stepIndex}][content]" rows="3"></textarea>
        <label class="mt-2">手順画像</label>
        <input type="file" id="step-image-${stepIndex}" class="step-image form-control" name="recipe[recipe_steps_attributes][${stepIndex}][image]">
        <br>
        <img id="preview-step-image-${stepIndex}" class="img-fluid img-thumbnail" style="display:none;" />
        <br>
        <button class="btn btn-danger remove-step">削除</button>
      `;

      steps.appendChild(step);
      setTimeout(() => {
        addPreviewListener(stepIndex);
      }, 0);
      updateRemoveStepButton();
    });
  }
});


// レシピ画像のプレビュー
function previewRecipeImage(inputImage, previewImage) {
  inputImage.addEventListener("change", (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();

    reader.onloadend = () => {
      previewImage.src = reader.result;
    };

    if (file) {
      reader.readAsDataURL(file);
      previewImage.style.display = "block";
    } else {
      previewImage.src = "";
      previewImage.style.display = "none";
    }
  });
}

// 手順画像のプレビュー
function addPreviewListener(stepIndex) {
  const stepImageInput = document.getElementById(`step-image-${stepIndex}`);
  const previewStepImage = document.getElementById(`preview-step-image-${stepIndex}`);

  stepImageInput.addEventListener("change", (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();

    reader.onloadend = () => {
      previewStepImage.src = reader.result;
      previewStepImage.style.display = "block";
    };

    if (file) {
      reader.readAsDataURL(file);
    } else {
      previewStepImage.style.display = "none";
    }
  });
}
function updateRemoveIngredientButton() {
  const removeIngredientButtons = document.querySelectorAll(".remove-ingredient");
  removeIngredientButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      const ingredientRow = button.closest(".ingredient-row");
      ingredientRow.remove();
    });
  });
}

// 手順の削除ボタンの更新
function updateRemoveStepButton() {
  const removeStepButtons = document.querySelectorAll(".remove-step");
  removeStepButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      const stepRow = button.closest(".step-row");
      stepRow.remove();
    });
  });
}

document.addEventListener("DOMContentLoaded", () => {
  // レシピ画像
  const recipeInputImage = document.getElementById("recipe_image");
  const recipePreviewImage = document.getElementById("preview");
  previewRecipeImage(recipeInputImage, recipePreviewImage);

  // 既存の手順の画像プレビュー
  const stepImages = document.querySelectorAll(".step-image");
  stepImages.forEach((stepImage, index) => {
    addPreviewListener(index);
  });
});
