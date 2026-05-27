const express = require('express');
const app = express();

// Importamos TODAS las rutas que ya creaste (Mercancías, Usuarios, Contenedores, Auth)
const mercanciasRoutes = require('./routes/mercanciasRoutes');
const usuariosRoutes = require('./routes/usuariosRoutes');
const contenedoresRoutes = require('./routes/contenedoresRoutes');
const authRoutes = require('./routes/authRoutes');

// Configuración CORS (esto es lo que permite que tu Angular hable con el Backend)
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    next();
});

app.use(express.json());

// Aquí conectamos todas tus rutas. Cada una es una pieza del rompecabezas.
app.use('/api/mercancias', mercanciasRoutes);
app.use('/api/usuarios', usuariosRoutes);
app.use('/api/contenedores', contenedoresRoutes);
app.use('/api/auth', authRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`🚀 Servidor Backend organizado y corriendo en http://localhost:${PORT}`);
});