const express = require('express');
const router = express.Router();
const mercanciasController = require('../controllers/mercanciasController');

// Cuando el servidor recibe un GET en la ruta principal, ejecuta el controlador
router.get('/', mercanciasController.obtenerMercancias);

module.exports = router;