import 'dotenv/config';
import app from './app.js';
import syncDatabase from './config/sync.js';

const PORT = process.env.PORT || 3000;

syncDatabase().then(() => {
  app.listen(PORT, () => {
    console.log(`🚀 GreenLife rodando em http://localhost:${PORT}`);
  });
});