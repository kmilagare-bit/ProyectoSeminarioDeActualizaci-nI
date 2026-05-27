const pool = require('../db');

exports.obtenerContenedores = async (req, res) => {
    try {
        const resultado = await pool.query('SELECT * FROM contenedores'); // Asegúrate que tu tabla se llame 'contenedores'
        res.json(resultado.rows);
    } catch (error) {
        console.error(error.message);
        res.status(500).send('Error al obtener los contenedores');
    }
};