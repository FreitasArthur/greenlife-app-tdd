import { DataTypes } from 'sequelize';
import sequelize from '../../config/database.js';

const Action = sequelize.define('Action', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  tipId: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  waterSaved: {
    type: DataTypes.FLOAT,
    defaultValue: 0,
    comment: 'Litros economizados'
  },
  energySaved: {
    type: DataTypes.FLOAT,
    defaultValue: 0,
    comment: 'kWh economizados'
  }
}, {
  tableName: 'actions',
  timestamps: true,
  underscored: true
});

export default Action;