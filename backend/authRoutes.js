// backend/routes/authRoutes.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Definición de las rutas para autenticación
router.post('/login', authController.login);
router.post('/recuperar-usuario', authController.recuperarUsuario);
router.post('/olvide-contrasena', authController.olvideContrasena);

module.exports = router;