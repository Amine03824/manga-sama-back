BEGIN;

-- Ajout des rôles
INSERT INTO "role" ("role_name") VALUES 
  ('Admin'),
  ('User');

COMMIT;  
