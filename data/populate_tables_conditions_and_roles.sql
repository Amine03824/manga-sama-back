BEGIN;

-- Ajout des catégories de mangas
INSERT INTO "category" ("category_name") VALUES 
('Shōnen'), 
('Seinen'), 
('Shōjo'), 
('Josei'), 
('Kodomo'), 
('Seijin');

-- Ajout des conditions d'articles
INSERT INTO "condition" ("condition_name") VALUES 
  ('Acceptable'),
  ('Bon'),
  ('Parfait');

-- Ajout des rôles
INSERT INTO "role" ("role_name") VALUES 
  ('Admin'),
  ('User');

COMMIT;  
