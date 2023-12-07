BEGIN;

-- Ajout des conditions d'articles
INSERT INTO "condition" ("condition_name") VALUES 
  ('Acceptable'),
  ('Bon'),
  ('Parfait');

COMMIT;  
