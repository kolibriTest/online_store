// products.js

document.addEventListener('turbo:load', () => {
    // Обробка успішного AJAX-запиту
    document.addEventListener('ajax:success', (event) => {
      const button = event.target; // Отримуємо кнопку, яка викликала подію
      const productContainer = button.closest('.product'); // Знаходимо контейнер продукту
  
      if (productContainer) {
        productContainer.remove(); // Видаляємо продукт із DOM
        alert('Продукт успішно видалено!');
      }
    });
  
    // Обробка помилки при AJAX-запиті
    document.addEventListener('ajax:error', () => {
      alert('Сталася помилка при видаленні продукту.');
    });
  });
  