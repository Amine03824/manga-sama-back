BEGIN;

-- Ajout des catégories de mangas
INSERT INTO "category" ("category_name") VALUES 
('Shōnen'), 
('Seinen'), 
('Shōjo'), 
('Josei'), 
('Kodomo'), 
('Seijin');

COMMIT;  