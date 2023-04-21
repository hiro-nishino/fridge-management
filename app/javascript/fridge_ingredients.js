
document.addEventListener('DOMContentLoaded', function() {
  const addIngredientButton = document.getElementById('add-ingredient');
  const ingredientsFields = document.getElementById('ingredients-fields');

  addIngredientButton.addEventListener('click', function() {
    const newRow = document.querySelector('.ingredient-row').cloneNode(true);
    newRow.querySelector('input[name="ingredient_name[]"]').value = '';
    newRow.querySelector('input[name="quantity[]"]').value = '';
    ingredientsFields.appendChild(newRow);
  });
});