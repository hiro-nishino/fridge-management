document.addEventListener("turbolinks:load", () => {
  const addIngredientBtn = document.getElementById("add-ingredient");

  if (addIngredientBtn) {
    addIngredientBtn.addEventListener("click", () => {
      const ingredientsFields = document.getElementById("ingredients-fields");
      const newRow = document.createElement("div");
      newRow.className = "ingredient-row";
      newRow.innerHTML = `
        <label for="ingredient_name">食材名</label>
        <input type="text" name="name[]" id="ingredient_name">

        <label for="ingredient_quantity">数量</label>
        <input type="text" name="quantity[]" id="ingredient_quantity">

        <label for="ingredient_expiration_date">賞味期限</label>
        <input type="date" name="expiration_date[]" id="ingredient_expiration_date">
      `;

      ingredientsFields.appendChild(newRow);
    });
  }
});