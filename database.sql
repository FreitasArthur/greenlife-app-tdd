CREATE DATABASE IF NOT EXISTS greenlife_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE greenlife_db;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  full_name VARCHAR(100),
  bio VARCHAR(255),
  profile_picture VARCHAR(255) DEFAULT 'default-profile.png',
  role ENUM('user', 'admin') DEFAULT 'user',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  icon VARCHAR(50),
  tips_count INT DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tips (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  category_id INT NOT NULL,
  user_id INT NOT NULL,
  likes_count INT DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS actions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  tip_id INT,
  description TEXT NOT NULL,
  water_saved FLOAT DEFAULT 0 COMMENT 'Litros economizados',
  energy_saved FLOAT DEFAULT 0 COMMENT 'kWh economizados',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (tip_id) REFERENCES tips(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS comments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  tip_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (tip_id) REFERENCES tips(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favorites (
  user_id INT NOT NULL,
  tip_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, tip_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (tip_id) REFERENCES tips(id) ON DELETE CASCADE
);

INSERT INTO categories (name, icon) VALUES
  ('Reciclagem', '♻️'),
  ('Energia', '⚡'),
  ('Água', '💧'),
  ('Alimentação', '🍎'),
  ('Mobilidade', '🚌');

INSERT INTO users (username, email, password, full_name, role) VALUES
  ('admin', 'admin@greenlife.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador', 'admin');

INSERT INTO tips (title, description, category_id, user_id) VALUES
  ('Como separar o lixo corretamente em casa', 'Separe resíduos secos, orgânicos e perigosos. Uma simples organização reduz o desperdício em até 60%.', 1, 1),
  ('Reduza o consumo de energia em stand-by', 'Desligar aparelhos da tomada no stand-by pode economizar até 10% da conta de luz mensal.', 2, 1),
  ('Banhos mais curtos, planeta mais saudável', 'Reduzir o banho de 15 para 5 minutos economiza cerca de 90 litros de água por dia.', 3, 1),
  ('Compostagem doméstica em 5 passos', 'Transforme restos de comida em adubo rico para plantas. Reduz o lixo orgânico em até 30%.', 4, 1),
  ('Use transporte público ou bicicleta', 'Substituir o carro particular uma vez por semana reduz em média 2,4kg de CO₂ por dia.', 5, 1);