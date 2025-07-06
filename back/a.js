import express from 'express';
import mysql from 'mysql2';
import cors from 'cors';
import bodyParser from 'body-parser';
import session from 'express-session';
import nodemailer from 'nodemailer'; 


const app = express();
const port = 3000;

app.use(session({
  secret: 'facu_tiene_un_back_letal', // poné cualquier texto
  resave: false,
  saveUninitialized: true
}));

// Conexión a MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345678',
  database: 'login'
});

db.connect(err => {
  if (err) throw err;
  console.log('Conectado a MySQL ✔️');
});

app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// ------------------------- REGISTRO -------------------------
app.post('/registrar', (req, res) => {
  const { nombre, correo, contrasena } = req.body;
  const sql = 'INSERT INTO usuario (nombre, correo, contraseña) VALUES (?, ?, ?)';
  db.query(sql, [nombre, correo, contrasena], (err, result) => {
    if (err) {
      console.error('Error al guardar en la BD ❌:', err);
      return res.status(500).json({ error: 'Error al registrar usuario' });
    }
    res.json({ mensaje: 'Registro exitoso 🚀' });
  });
});

// ------------------------- LOGIN -------------------------
app.post('/login', (req, res) => {
  const { correo, contrasena } = req.body;

  if (!correo || !contrasena) {
    return res.status(400).json({ error: 'Faltan datos de acceso' });
  }

  const sql = 'SELECT * FROM usuario WHERE Correo = ? AND Contraseña = ? LIMIT 1';
  db.query(sql, [correo, contrasena], (err, results) => {
    if (err) {
      console.error('❌ Error en login:', err.sqlMessage);
      return res.status(500).json({ error: 'Error al intentar iniciar sesión' });
    }

    if (results.length === 0) {
      return res.status(401).json({ error: 'Credenciales incorrectas' });
    }

    // Usuario autenticado
    const user = results[0];

    // Si querés iniciar sesión en el servidor:
    req.session.userId = user.Id;

    res.json({
      mensaje: 'Sesión iniciada',
      id: user.Id,
      nombre: user.Nombre,
      correo: user.Correo
    });
  });
});



// ------------------------- RUTA VIAJES -------------------------
app.get('/viajes', (req, res) => {
  const sql = 'SELECT * FROM vuelos';
  db.query(sql, (err, resultados) => {
    if (err) {
      console.error('❌ Error al obtener los vuelos:', err.sqlMessage);
      return res.status(500).json({ error: 'Error al recuperar vuelos' });
    }
    res.json(resultados);
  });
});

// ------------------------- RUTA PAQUETE -------------------------
app.get('/paquete/:Id', (req, res) => {
  const id = req.params.Id;
  const sql = 'SELECT * FROM vuelos WHERE Id = ?';
  db.query(sql, [id], (err, results) => {
    if (err) {
      console.error('❌ Error al buscar el paquete:', err.sqlMessage);
      return res.status(500).json({ error: 'Error interno del servidor' });
    }
    if (results.length === 0) {
      return res.status(404).json({ error: 'Paquete no encontrado' });
    }
    res.json(results[0]);
  });
});

// Guardar paquete como favorito para usuario
app.post('/favoritos', (req, res) => {
  const { usuario_id, vuelo_id } = req.body;

  if (!usuario_id || !vuelo_id) {
    return res.status(400).json({ error: 'Faltan datos para guardar favorito' });
  }

  // Insertar en tabla favoritos
  const sql = 'INSERT INTO favoritos (usuario_id, vuelos_id) VALUES (?, ?)';
  db.query(sql, [usuario_id, vuelo_id], (err, result) => {
    if (err) {
      console.error('❌ Error al guardar favorito:', err);
      return res.status(500).json({ error: 'Error al guardar favorito' });
    }
    res.json({ mensaje: 'Favorito guardado correctamente' });
  });
});

/* ✅ 👉 1. AGREGAR RUTA PARA OBTENER FAVORITOS DE UN USUARIO
   Método: GET
   Ruta: /favoritos/:usuarioId

   → Esta ruta devuelve todos los vuelos favoritos de un usuario.
*/
app.get('/favoritos/:usuarioId', (req, res) => {
  const usuarioId = req.params.usuarioId;
  const sql = `
    SELECT v.* 
    FROM favoritos f
    JOIN vuelos v ON v.Id = f.vuelos_id
    WHERE f.usuario_id = ?
  `;
  db.query(sql, [usuarioId], (err, results) => {
    if (err) {
      console.error('❌ Error al obtener favoritos:', err);
      return res.status(500).json({ error: 'Error al obtener favoritos' });
    }
    res.json(results);
  });
});

/* ✅ 👉 2. AGREGAR RUTA PARA ELIMINAR FAVORITO DE UN USUARIO
   Método: DELETE
   Ruta: /favoritos/:usuarioId/:vuelosId

   → Permite borrar un vuelo favorito de un usuario.
*/
app.delete('/favoritos/:usuarioId/:vuelosId', (req, res) => {
  const { usuarioId, vuelosId } = req.params;
  const sql = 'DELETE FROM favoritos WHERE usuario_id = ? AND vuelos_id = ?';
  db.query(sql, [usuarioId, vuelosId], (err, result) => {
    if (err) {
      console.error('❌ Error al eliminar favorito:', err);
      return res.status(500).json({ error: 'Error al eliminar favorito' });
    }
    res.json({ mensaje: 'Favorito eliminado' });
  });
});

/* ✅ 👉 3. AGREGAR RUTA PARA ENVIAR EMAIL (opcional, simulado o real)
   Método: POST
   Ruta: /enviar-gmail

   → Recibe un correo destino y datos del paquete para enviar por mail.
*/


app.post('/enviar-gmail', (req, res) => {
  const { correoDestino, paquete } = req.body;

  // Creamos el transporter de nodemailer usando Ethereal (para pruebas)
  nodemailer.createTestAccount((err, account) => {
    if (err) {
      console.error('Error creando cuenta de prueba:', err);
      return res.status(500).json({ error: 'Error interno al crear cuenta de email' });
    }

    const transporter = nodemailer.createTransport({
      host: account.smtp.host,
      port: account.smtp.port,
      secure: account.smtp.secure,
      auth: {
        user: account.user,
        pass: account.pass
      }
    });

    const mailOptions = {
      from: account.user,
      to: correoDestino,
      subject: 'Tu paquete elegido',
      text: `Tu paquete seleccionado:
- Destino ida: ${paquete.destinoida}
- Destino vuelta: ${paquete.destinovuelta}
- Precio: ${paquete.precio}`
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error('Error enviando mail:', error);
        return res.status(500).json({ error: 'Error al enviar el correo' });
      }

      // Obtener URL de vista previa para Ethereal
      const previewUrl = nodemailer.getTestMessageUrl(info);
      console.log('Vista previa del correo:', previewUrl);

      // Respondemos con mensaje y previewUrl para mostrar en frontend
      res.json({ mensaje: 'Correo enviado correctamente (prueba)', previewUrl });
    });
  });
});



/* ✅ 👉 4. AGREGAR RUTA PARA CERRAR SESIÓN
   Método: POST
   Ruta: /logout

   → Destruye la sesión pero NO borra nada en la BD.
*/
app.post('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Error al cerrar sesión' });
    }
    res.json({ mensaje: 'Sesión cerrada' });
  });
});


// ------------------------- INICIO SERVIDOR -------------------------
app.listen(port, '0.0.0.0', () => {
  console.log(`🌐 Servidor escuchando en http://localhost:${port}`);
});