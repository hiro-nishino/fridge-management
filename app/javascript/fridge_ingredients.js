document.addEventListener('turbolinks:load', () => {
  const addIngredientButton = document.getElementById('add-ingredient');
  const ingredientsFields = document.getElementById('ingredients-fields');

  if (!addIngredientButton || !ingredientsFields) return;

  addIngredientButton.addEventListener('click', () => {
    const newIngredient = document.createElement('div');
    newIngredient.innerHTML = `
      <div class="ingredient-row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="name">食材名</label>
            <input type="text" name="name[]" class="form-control" placeholder="食材名">
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="quantity">数量</label>
            <input type="text" name="quantity[]" class="form-control" placeholder="数量">
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
             <label for="expiration_date">賞味期限</label>
             <input type="date" name="expiration_date[]" class="form-control" placeholder="消費期限">
          </div>
        </div>
      </div>
    `;
    ingredientsFields.appendChild(newIngredient);
  });
});