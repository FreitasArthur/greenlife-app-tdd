import User from '../modules/user/user.model.js';
import Tip from '../modules/tip/tip.model.js';
import Category from '../modules/category/category.model.js';
import Action from '../modules/action/action.model.js';
import Comment from '../modules/comment/comment.model.js';

// User → Tip (um usuário cria muitas dicas)
User.hasMany(Tip, { foreignKey: 'userId', as: 'tips' });
Tip.belongsTo(User, { foreignKey: 'userId', as: 'author' });

// Category → Tip (uma categoria tem muitas dicas)
Category.hasMany(Tip, { foreignKey: 'categoryId', as: 'tips' });
Tip.belongsTo(Category, { foreignKey: 'categoryId', as: 'category' });

// User → Action (um usuário registra muitas ações)
User.hasMany(Action, { foreignKey: 'userId', as: 'actions' });
Action.belongsTo(User, { foreignKey: 'userId', as: 'user' });

// Tip → Action (uma dica pode gerar muitas ações)
Tip.hasMany(Action, { foreignKey: 'tipId', as: 'actions' });
Action.belongsTo(Tip, { foreignKey: 'tipId', as: 'tip' });

// Tip → Comment (uma dica tem muitos comentários)
Tip.hasMany(Comment, { foreignKey: 'tipId', as: 'comments' });
Comment.belongsTo(Tip, { foreignKey: 'tipId', as: 'tip' });

// User → Comment (um usuário faz muitos comentários)
User.hasMany(Comment, { foreignKey: 'userId', as: 'comments' });
Comment.belongsTo(User, { foreignKey: 'userId', as: 'user' });

// Favoritos: User ↔ Tip (muitos para muitos)
User.belongsToMany(Tip, { through: 'favorites', as: 'favoriteTips', foreignKey: 'userId' });
Tip.belongsToMany(User, { through: 'favorites', as: 'favoritedBy', foreignKey: 'tipId' });

export { User, Tip, Category, Action, Comment };