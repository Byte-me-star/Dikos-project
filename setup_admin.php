<?php
require_once 'includes/db.php';
$errors = [];
$success = '';

// Safety: if any users already exist, don't allow re-running this page
$existing = $pdo->query("SELECT COUNT(*) AS c FROM users")->fetch()['c'];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $existing == 0) {
    $owner_user = trim($_POST['owner_username']);
    $owner_pass = $_POST['owner_password'];
    $owner_name = trim($_POST['owner_name']);
    $cashier_user = trim($_POST['cashier_username']);
    $cashier_pass = $_POST['cashier_password'];
    $cashier_name = trim($_POST['cashier_name']);

    if ($owner_user && $owner_pass && $cashier_user && $cashier_pass) {
        $stmt = $pdo->prepare("INSERT INTO users (username, password, full_name, role) VALUES (?,?,?, 'owner')");
        $stmt->execute([$owner_user, password_hash($owner_pass, PASSWORD_DEFAULT), $owner_name ?: 'Owner']);

        $stmt = $pdo->prepare("INSERT INTO users (username, password, full_name, role) VALUES (?,?,?, 'cashier')");
        $stmt->execute([$cashier_user, password_hash($cashier_pass, PASSWORD_DEFAULT), $cashier_name ?: 'Cashier']);

        $success = "Accounts created! You can now log in. For security, please delete setup_admin.php from your server now.";
    } else {
        $errors[] = "Please fill in all required fields.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>First-Time Setup - <?= htmlspecialchars(RESTAURANT_NAME) ?></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Montserrat:wght@700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="login-wrapper">
  <div class="login-card" style="max-width:520px;">
    <img src="assets/images/logo.jpg" class="logo" alt="Logo">
    <h3>First-Time Setup</h3>
    <p class="subtitle">Create your first Owner and Cashier accounts</p>

    <?php if ($existing > 0): ?>
      <div class="alert alert-warning">Setup already completed. Accounts already exist.
      Please delete <code>setup_admin.php</code> and go to
      <a href="login_owner.php">Owner Login</a> or <a href="login_cashier.php">Cashier Login</a>.</div>
    <?php else: ?>
      <?php if ($success): ?>
        <div class="alert alert-success"><?= $success ?></div>
        <a href="login_owner.php" class="btn btn-brand">Go to Owner Login</a>
      <?php else: ?>
        <?php foreach ($errors as $e): ?><div class="alert alert-danger"><?= htmlspecialchars($e) ?></div><?php endforeach; ?>
        <form method="POST" class="text-start">
          <h5 class="mt-2" style="color:var(--dark-green)">Owner Account</h5>
          <div class="mb-2"><input type="text" name="owner_name" class="form-control" placeholder="Full Name"></div>
          <div class="mb-2"><input type="text" name="owner_username" class="form-control" placeholder="Owner Username" required></div>
          <div class="mb-3 password-wrapper">
            <input type="password" id="owner_password" name="owner_password" class="form-control" placeholder="Owner Password" required>
            <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
          </div>

          <h5 class="mt-3" style="color:var(--dark-green)">Cashier Account</h5>
          <div class="mb-2"><input type="text" name="cashier_name" class="form-control" placeholder="Full Name"></div>
          <div class="mb-2"><input type="text" name="cashier_username" class="form-control" placeholder="Cashier Username" required></div>
          <div class="mb-3 password-wrapper">
            <input type="password" id="cashier_password" name="cashier_password" class="form-control" placeholder="Cashier Password" required>
            <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
          </div>

          <button type="submit" class="btn btn-brand">Create Accounts</button>
        </form>
      <?php endif; ?>
    <?php endif; ?>
  </div>
</div>
<script src="assets/js/script.js"></script>
</body>
</html>
