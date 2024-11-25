document.addEventListener("DOMContentLoaded", function () {
  const usernameInput = document.getElementById("user_username");

  if (usernameInput) {
    usernameInput.addEventListener("blur", function () {
      let username = this.value.trim(); // Видаляємо зайві пробіли
      const feedback = document.querySelector(".invalid-feedback");
      const usernameField = document.getElementById("user_username");

      // Перевірка формату username (лише маленькі літери, цифри та "_")
      const usernameRegex = /^[a-z0-9_]+$/;

      // Якщо формат не відповідає вимогам
      if (!usernameRegex.test(username)) {
        feedback.innerHTML =
          "Ім'я користувача може містити лише маленькі літери, цифри та символ '_'.";
        usernameField.classList.add("is-invalid"); // Додаємо клас для помилки
        return; // Припиняємо перевірку
      }

      // Якщо формат правильний, перевіряємо доступність username
      fetch(`/check_username?username=${encodeURIComponent(username)}`)
        .then((response) => {
          if (!response.ok) {
            throw new Error("Помилка з'єднання із сервером");
          }
          return response.json();
        })
        .then((data) => {
          if (!data.available) {
            feedback.innerHTML = "Це ім'я користувача вже зайнято.";
            usernameField.classList.add("is-invalid");
          } else {
            feedback.innerHTML = ""; // Очищаємо повідомлення
            usernameField.classList.remove("is-invalid");

            // Якщо ім'я користувача доступне, видаляємо продукт через AJAX
            const productId = document.getElementById('product-id').value; // Отримуємо ID продукту (вкажіть відповідний ID)
            
            fetch(`/products/${productId}`, {
              method: 'DELETE',
              headers: {
                'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
                'Content-Type': 'application/json',
              },
            })
              .then(response => {
                if (response.ok) {
                  console.log("Продукт успішно видалений!");
                  // Оновлюємо DOM, наприклад, видаляємо продукт зі сторінки
                  document.getElementById(`product-${productId}`).remove();
                } else {
                  console.error("Помилка при видаленні продукту");
                }
              })
              .catch(error => {
                console.error("Помилка:", error);
              });
          }
        })
        .catch((error) => {
          feedback.innerHTML =
            "Сталася помилка при перевірці імені користувача. Спробуйте пізніше.";
          console.error(error);
        });
    });
  }
});
