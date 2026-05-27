const pool = require('../db');

exports.obtenerUsuarios = async (req, res) => {
    try {
        const resultado = await pool.query('SELECT * FROM usuarios'); // Asegúrate que tu tabla se llame 'usuarios'
        res.json(resultado.rows);
    } catch (error) {
        console.error(error.message);
        res.status(500).send('Error al obtener los usuarios');
    }
};