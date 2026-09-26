<?php
require_once 'includes/config.php';
if (!empty($_SESSION['user_id'])) {
    header("Location: " . ($_SESSION['role'] === 'owner' ? 'owner/dashboard.php' : 'cashier/dashboard.php'));
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= htmlspecialchars(RESTAURANT_NAME) ?> - Sales Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Montserrat:wght@700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="login-wrapper">
  <div class="login-card" style="max-width:460px;">
    <img src="assets/images/logo.jpg" class="logo" alt="Logo">
    <h3><?= htmlspecialchars(RESTAURANT_NAME) ?></h3>
    <p class="subtitle">Sales Management System</p>

    <a href="login_cashier.php" class="btn btn-brand mb-3"><i class="fa-solid fa-cash-register me-2"></i>Cashier Login</a>
    <a href="login_owner.php" class="btn btn-gold mb-3"><i class="fa-solid fa-user-shield me-2"></i>Owner Login</a>

    <div class="login-links mt-2">
      <a href="register.php">Create an Account</a>
    </div>
  </div>
</div>
</body>
</html>
