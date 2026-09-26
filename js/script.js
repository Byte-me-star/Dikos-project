// ============================================================
// Diko's Farm Grill and Restaurant - Cart & Order Logic
// Requires a global PRODUCTS array (id, product_name, price, stock...)
// ============================================================

let cart = {}; // { productId: qty }

function getProduct(id) {
  return PRODUCTS.find(p => parseInt(p.id) === parseInt(id));
}

function changeQty(productId, delta) {
  const product = getProduct(productId);
  if (!product) return;

  const current = cart[productId] || 0;
  let next = current + delta;

  if (next < 0) next = 0;
  if (next > product.stock) {
    Swal.fire('Not enough stock', `Only ${product.stock} left for ${product.product_name}.`, 'warning');
    next = product.stock;
  }

  if (next === 0) {
    delete cart[productId];
  } else {
    cart[productId] = next;
  }

  document.getElementById('qty-' + productId).innerText = next;
  renderCart();
}

function renderCart() {
  const container = document.getElementById('cartItems');
  const ids = Object.keys(cart);

  if (ids.length === 0) {
    container.innerHTML = '<p class="text-muted small">No items yet.</p>';
    document.getElementById('cartTotal').innerText = '₱0.00';
    updateChange();
    return;
  }

  let html = '';
  let total = 0;

  ids.forEach(id => {
    const product = getProduct(id);
    const qty = cart[id];
    const subtotal = product.price * qty;
    total += subtotal;
    html += `<div class="cart-item">
      <span>${product.product_name} x${qty}</span>
      <span>₱${subtotal.toFixed(2)}</span>
    </div>`;
  });

  container.innerHTML = html;
  document.getElementById('cartTotal').innerText = '₱' + total.toFixed(2);
  updateChange();
}

function updateChange() {
  const total = parseFloat(document.getElementById('cartTotal').innerText.replace('₱', '')) || 0;
  const cash = parseFloat(document.getElementById('cashInput').value) || 0;
  const change = cash - total;
  document.getElementById('changeAmount').innerText = '₱' + (change > 0 ? change.toFixed(2) : '0.00');
}

function clearCart() {
  cart = {};
  PRODUCTS.forEach(p => {
    const el = document.getElementById('qty-' + p.id);
    if (el) el.innerText = '0';
  });
  document.getElementById('cashInput').value = '';
  renderCart();
}

function placeOrder() {
  const ids = Object.keys(cart);
  if (ids.length === 0) {
    Swal.fire('Cart is empty', 'Please add at least one product.', 'info');
    return;
  }

  const total = parseFloat(document.getElementById('cartTotal').innerText.replace('₱', '')) || 0;
  const cash = parseFloat(document.getElementById('cashInput').value) || 0;

  if (cash < total) {
    Swal.fire('Insufficient Cash', 'Cash received is less than the total.', 'error');
    return;
  }

  const items = ids.map(id => ({
    product_id: id,
    quantity: cart[id]
  }));

  Swal.fire({
    title: 'Processing order...',
    allowOutsideClick: false,
    didOpen: () => Swal.showLoading()
  });

  fetch('process_order.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ items, cash })
  })
  .then(res => res.json())
  .then(data => {
    if (data.success) {
      Swal.fire('Order Placed!', 'Redirecting to receipt...', 'success').then(() => {
        window.location.href = 'receipt.php?id=' + data.order_id;
      });
    } else {
      Swal.fire('Error', data.message || 'Something went wrong.', 'error');
    }
  })
  .catch(() => Swal.fire('Error', 'Could not connect to server.', 'error'));
}

// ============================================================
// Password show/hide toggle (login, register, setup pages)
// Usage: <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
// placed right after the <input type="password"> inside a .password-wrapper
// ============================================================
function togglePassword(iconWrapper) {
  const input = iconWrapper.previousElementSibling;
  const icon = iconWrapper.querySelector('i');
  if (!input) return;

  if (input.type === 'password') {
    input.type = 'text';
    icon.classList.remove('fa-eye');
    icon.classList.add('fa-eye-slash');
  } else {
    input.type = 'password';
    icon.classList.remove('fa-eye-slash');
    icon.classList.add('fa-eye');
  }
}

