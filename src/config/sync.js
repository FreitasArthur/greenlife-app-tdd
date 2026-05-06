import sequelize from './database.js';
import './associations.js';

const syncDatabase = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Conexão com o banco estabelecida.');

    await sequelize.sync({ alter: true });
    console.log('✅ Tabelas sincronizadas com sucesso.');
  } catch (error) {
    console.error('❌ Erro ao conectar com o banco:', error.message);
  }
};

export default syncDatabase;