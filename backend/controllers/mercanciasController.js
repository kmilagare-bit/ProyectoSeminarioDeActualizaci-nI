const express = require('express');
const router = express.Router();
// Esta línea es la conexión vital:
const mercanciasController = require('../controllers/mercanciasController');

// Esto dice: "Cuando alguien pida la ruta, ejecuta la función del controlador"
router.get('/', mercanciasController.obtenerMercancias);

module.exports = router;