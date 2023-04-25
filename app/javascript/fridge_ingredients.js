function addIngredientForm() {
}
document.addEventListener('turbolinks:load', () => {
  const addIngredientButton = document.getElementById('add-ingredient-button');
  const ingredientList = document.getElementById('ingredient-list');

  if (!addIngredientButton || !ingredientList) return;

  addIngredientButton.addEventListener('click', () => {
    const newIngredient = document.createElement('div');
    newIngredient.innerHTML = `
      <div class="form-row">
        <div class="form-group col-md-4">
          <input type="text" name="name[]" class="form-control" placeholder="食材名">
        </div>
        <div class="form-group col-md-4">
          <input type="number" name="quantity[]" class="form-control" placeholder="数量">
        </div>
        <div class="form-group col-md-4">
          <input type="date" name="expiration_date[]" class="form-control" placeholder="消費期限">
        </div>
      </div>
    `;
    ingredientList.appendChild(newIngredient);
  });
});

export { addIngredientForm };