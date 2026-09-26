<?php
require_once 'includes/db.php';
require_once 'includes/auth.php';
$error = '';
$success = '';
$role = ((isset($_GET['role']) ? $_GET['role'] : '') === 'owner') ? 'owner' : 'cashier';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $role = $_POST['role'] === 'owner' ? 'owner' : 'cashier';
    $full_name = trim($_POST['full_name']);
    $username = trim($_POST['username']);
    $password = $_POST['password'];
    $confirm  = $_POST['confirm_password'];
    $secret   = $_POST['secret_code'] ?? '';

    if (!$full_name || !$username || !$password) {
        $error = "Please fill in all required fields.";
    } elseif ($password !== $confirm) {
        $error = "Passwords do not match.";
    } elseif ($role === 'owner' && $secret !== OWNER_SECRET_CODE) {
        $error = "Invalid owner secret code. Owner registration is private/restricted.";
    } else {
        $check = $pdo->prepare("SELECT id FROM users WHERE username = ?");
        $check->execute([$username]);
        if ($check->fetch()) {
            $error = "That username is already taken.";
        } else {
            $stmt = $pdo->prepare("INSERT INTO users (username, password, full_name, role) VALUES (?,?,?,?)");
            $stmt->execute([$username, password_hash($password, PASSWORD_DEFAULT), $full_name, $role]);
            $success = ucfirst($role) . " account created successfully! You may now log in.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register - <?= htmlspecialchars(RESTAURANT_NAME) ?></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Montserrat:wght@700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="login-wrapper">
  <div class="login-card">
    <img src="assets/images/logo.jpg" class="logo" alt="Logo">
    <h3>Create Account</h3>
    <p class="subtitle">Register a new user</p>

    <?php if ($error): ?><div class="alert alert-danger"><?= htmlspecialchars($error) ?></div><?php endif; ?>
    <?php if ($success): ?>
      <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
      <a href="<?= $role === 'owner' ? 'login_owner.php' : 'login_cashier.php' ?>" class="btn btn-brand">Go to Login</a>
    <?php else: ?>
      <form method="POST" class="text-start">
        <div class="mb-3">
          <label class="form-label fw-semibold">Account Type</label>
          <select name="role" id="roleSelect" class="form-select" onchange="toggleSecret()">
            <option value="cashier" <?= $role === 'cashier' ? 'selected' : '' ?>>Cashier</option>
            <option value="owner" <?= $role === 'owner' ? 'selected' : '' ?>>Owner (Private / Restricted)</option>
          </select>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Full Name</label>
          <input type="text" name="full_name" class="form-control" required>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Username</label>
          <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Password</label>
          <div class="password-wrapper">
            <input type="password" id="password" name="password" class="form-control" required>
            <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Confirm Password</label>
          <div class="password-wrapper">
            <input type="password" id="confirm_password" name="confirm_password" class="form-control" required>
            <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
          </div>
        </div>
        <div class="mb-3" id="secretField" style="<?= $role === 'owner' ? '' : 'display:none;' ?>">
          <label class="form-label fw-semibold">Owner Secret Code</label>
          <div class="password-wrapper">
            <input type="password" id="secret_code" name="secret_code" class="form-control" placeholder="Required for owner accounts only">
            <span class="password-toggle" onclick="togglePassword(this)"><i class="fa-solid fa-eye"></i></span>
          </div>
          <small class="text-muted">Ask the restaurant administrator for this code.</small>
        </div>
        <button type="submit" class="btn btn-brand">Register</button>
      </form>
    <?php endif; ?>

    <div class="login-links mt-3">
      <a href="login_cashier.php">Cashier Login</a> &nbsp;|&nbsp; <a href="login_owner.php">Owner Login</a>
    </div>
  </div>
</div>
<script src="assets/js/script.js"></script>
<script>
function toggleSecret() {
  const role = document.getElementById('roleSelect').value;
  document.getElementById('secretField').style.display = role === 'owner' ? 'block' : 'none';
}
</script>
</body>
</html>
