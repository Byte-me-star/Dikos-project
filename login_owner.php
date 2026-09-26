<?php
require_once 'includes/db.php';
require_once 'includes/auth.php';
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username']);
    $password = $_POST['password'];

    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND role = 'owner'");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if ($user && $user['status'] === 'active' && password_verify($password, $user['password'])) {
        login_user($user);
        header("Location: owner/dashboard.php");
        exit;
    } else {
        $error = "Invalid username or password, or account inactive.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Owner Login - <?= htmlspecialchars(RESTAURANT_NAME) ?></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Montserrat:wght@700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="login-wrapper">
  <div class="login-card">
    <img src="assets/images/logo.jpg" class="logo" alt="Logo">
    <h3><?= htmlspecialchars(RESTAURANT_NAME) ?></h3>
    <p class="subtitle"><i class="fa-solid fa-user-shield"></i> Owner / Admin Login</p>

    <?php if ($error): ?><div class="alert alert-danger"><?= htmlspecialchars($error) ?></div><?php endif; ?>

    <form method="POST" class="text-start">
      <div class="mb-3">
        <label class="form-label fw-semibold">Username</label>
        <input type="text" name="username" class="form-control" required autofocus>
      </div>
      <div class="mb-3">
        <label class="form-label fw-semibold">Password</label>
        <div class="password-wrapper">
          <input type="password" id="password" name="password" class="form-control" required>
          <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
        </div>
      </div>
      <button type="submit" class="btn btn-brand">Login</button>
    </form>

    <div class="login-links mt-3">
      <a href="register.php?role=owner">Register Owner Account (secret code required)</a><br>
      <a href="login_cashier.php">Cashier Login</a>
    </div>
  </div>
</div>
<script src="assets/js/script.js"></script>
</body>
</html>
