const express = require('express');
const router = express.Router();
const contenedoresController = require('../controllers/contenedoresController');

router.get('/', contenedoresController.obtenerContenedores);

module.exports = router;
