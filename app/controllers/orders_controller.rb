<h1>Ваш кошик</h1>

<% if @cart_items.any? %>
  <ul>
    <% @cart_items.each do |cart_item| %>
      <li>
        <%= cart_item.product.name %> - <%= cart_item.quantity %> шт.
        <%= link_to 'Видалити', cart_item_path(cart_item), method: :delete, data: { confirm: 'Ви впевнені?' } %>
      </li>
    <% end %>
  </ul>
  <p>Загальна сума: <%= @cart_items.sum { |item| item.product.price * item.quantity } %> грн</p>
  <%= link_to 'Перейти до оформлення замовлення', orders_path, class: 'btn btn-primary' %>
<% else %>
  <p>Ваш кошик порожній.</p>
<% end %>
