document.addEventListener('DOMContentLoaded', () => {
  const addIngredientButton = document.getElementById('add-ingredient');
  if (addIngredientButton) {
    addIngredientButton.addEventListener('click', (e) => {
      e.preventDefault();
      const ingredientsFields = document.getElementById('ingredients-fields');
      const newRow = document.createElement('div');
      newRow.className = 'ingredient-row';
      newRow.innerHTML = `
        <label for="name[]">食材名</label>
        <input type="text" name="name[]" id="name">
        <label for="quantity[]">数量</label>
        <input type="number" name="quantity[]" id="quantity">
        <label for="expiration_date[]">賞味期限</label>
        <input type="date" name="expiration_date[]" id="expiration_date">
      `;
      ingredientsFields.appendChild(newRow);
    });
  }
});
