<?php
require_once 'includes/config.php';
require_once 'includes/auth.php';
$role = $_SESSION['role'] ?? 'cashier';
logout_user();
header("Location: " . ($role === 'owner' ? 'login_owner.php' : 'login_cashier.php'));
exit;
