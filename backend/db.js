// db.js - Conexión con PostgreSQL
const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',           // Tu usuario por defecto de pgAdmin
  host: 'localhost',          // Servidor local
  database: 'puerto_db',      // Asegúrate de que este nombre exista en tu pgAdmin
  password: 'admin', // 👈 ¡BORRA ESTE TEXTO Y ESCRIBE AQUÍ TU CLAVE! (Mantén las comillas)
  port: 5432,                 // Puerto por defecto de PostgreSQL
});

// Validar la conexión en la terminal
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('❌ Error de conexión:', err.stack);
  } else {
    console.log('✅ ¡Conexión exitosa a PostgreSQL! El puente está activo.');
  }
});

module.exports = pool;