document.addEventListener("turbolinks:load", () => {
  const addButton = document.querySelector("#add-ingredient");
  if (addButton) {
    addButton.addEventListener("click", (event) => {
      event.preventDefault();
      const formIndex = document.querySelector("#form-index");
      let currentIndex = parseInt(formIndex.value, 10);
      const ingredientsWrapper = document.querySelector("#ingredients-wrapper");

      const newIngredient = document.createElement("div");
      newIngredient.innerHTML = `
        <label for="fridge_fridge_ingredients_attributes_${currentIndex}_name">食材名:</label>
        <input type="text" name="name[]" id="fridge_fridge_ingredients_attributes_${currentIndex}_name" />
        <label for="fridge_fridge_ingredients_attributes_${currentIndex}_quantity">数量:</label>
        <input type="number" name="quantity[]" id="fridge_fridge_ingredients_attributes_${currentIndex}_quantity" />
        <label for="fridge_fridge_ingredients_attributes_${currentIndex}_expiration_date">賞味期限:</label>
        <input type="date" name="expiration_date[]" id="fridge_fridge_ingredients_attributes_${currentIndex}_expiration_date" />
      `;
      ingredientsWrapper.appendChild(newIngredient);
      currentIndex += 1;
      formIndex.value = currentIndex;
    });
  }
});