-- Insérer les articles associés aux mangas
INSERT INTO "article" ("title", "description", "price", "image_url", "condition_id")
VALUES
  ('Fullmetal Alchemist Perfect Tome 1', 'Avec son subtil mélange d''action, d''humour, de suspense et de tragédie...', 10, 'http://localhost:3000/images/9782368529904', 2),
  ('Naruto Tome 1', 'Naruto est un garçon un peu spécial. Il est toujours tout seul et son caractère fougueux ne l''aide pas vraiment...', 15, 'http://localhost:3000/images/9782871294146', 1),
  ('Naruto Tome 2', 'Sasuke, Sakura et Naruto passent un test dont le but est de s''emparer de clochettes que détient le professeur Kakashi...', 12, 'http://localhost:3000/images/9782871294177', 3),
  ('Naruto Tome 3', 'En compagnie de Sasuke et de Sakura, Naruto, le pire garnement de l''école des ninjas du village caché de Konoha, réussit avec brio le test de survie imposé par maître Kakashi...', 18, 'http://localhost:3000/images/9782871294276', 1),
  ('Naruto Tome 4', 'Sasuke s''effondre après avoir voulu protéger Naruto... !! Déclenché à la fois par la rage et la tristesse, un étrange bouleversement se produit en Naruto...', 20, 'http://localhost:3000/images/9782871294412', 2),
  ('Naruto Tome 5', 'Un groupe d''aspirants ninjas venus d''un autre village sont venus à Konoha pour passer l''examen de sélection des ninjas de "moyenne classe"...', 15, 'http://localhost:3000/images/9782871294917', 3),
  ('Hunter X Hunter Tome 1', 'Dans les pas de son père, Gon quitte son village pour se présenter au difficile examen des hunters...', 10, 'http://localhost:3000/images/9782871292661', 2),
  ('Hunter X Hunter Tome 2', 'Le récit s''étoffe au fur et à mesure qu''apparaissent de nouveaux personnages secondaires. On notera surtout le mystérieux Hisoka dont la puissance semble sans limites et les motivations, inattendues...', 15, 'http://localhost:3000/images/9782871292678', 1),
  ('Hunter X Hunter Tome 3', 'Les épreuves qui, les unes après les autres, se dressent devant les candidats au titre de Hunter, nous permettent de découvrir le caractère et le passé souvent trouble de chacun...', 12, 'http://localhost:3000/images/9782871292685', 3),
  ('Hunter X Hunter Tome 4', '', 14, 'http://localhost:3000/images/9782871292692', 1),
  ('Hunter X Hunter Tome 5', '', 16, 'http://localhost:3000/images/9782871292708', 2),
  ('Death Note Tome 1', 'Light Yagami ramasse un étrange carnet oublié dans la cour de son lycée. Selon les instructions du carnet, la personne dont le nom est écrit dans les pages du Death Note mourra dans les 40 secondes !! Quelques jours plus tard, Light fait la connaissance de l''ancien propriétaire du carnet : Ryûk, un dieu de la mort ! Poussé par l''ennui, il a fait entrer le carnet sur terre. Ryûk découvre alors que Light a déjà commencé à remplir son carnet...', 18, 'http://localhost:3000/images/9782505000327', 3),
  ('Ubel Blatt Tome 0', 'La légende raconte que pour lutter contre une terrifiante armée des ténèbres, l''empereur missionna 14 vaillants guerriers à qui il confia 14 lances sacrées...', 10, 'http://localhost:3001/images/9782915513585', 2),
  ('Reborn !', 'Quand les bébés mafieux prennent le pouvoir ! Reborn, qui a l''apparence d''un bébé, est un tueur envoyé par le boss de la famille Vongola, une puissante organisation mafieuse, en quête de successeur...', 15, 'http://localhost:3000/images/9782723455862', 1),
  ('Monster Intégrale', 'La vie quotidienne de chacun est parsemée d''embûches. Celle du prometteur docteur Tenma ne fait pas exception à la règle. Mais comment aurait-il pu imaginer qu''en remplissant sa mission de médecin, en sauvant une vie humaine plutôt que de courir après la gloire, il donnerait naissance à une telle créature ! ? Ou se situe le bien, où se situe le mal ? ! Dans une Allemagne en pleine confusion depuis la réunification, des couples d''âge moyen, sans enfant, sont tués les uns après les autres. Le tueur en série a pour nom Johann ! Mais pourquoi s''en prend-il à ces couples ? Kenzô Tenma parcourt l''Allemagne pour retrouver la soeur jumelle du jeune homme. Celle-ci pourrait bien détenir des informations afin de percer le secret du " Monstre "...', 20, 'http://localhost:3000/images/9782505009993', 2),
  ('L''attaque des titans', 'Le monde appartient désormais aux Titans, des êtres gigantesques qui ont presque décimé l''Humanité... Un tome anniversaire avec des pages couleur et l''épisode 0, le one-shot inédit à l''origine de la série !', 15, 'http://localhost:3000/images/9782811679811', 3),
  ('Berserk', '"Vous qui entrez ici, abandonnez toute espérance. " Guts est un guerrier solitaire à l''épée démesurée. Marqué par un terrible passé, il parcourt le monde en semant la mort sur son passage. Un jour, il vient en aide à Puck, un elfe facétieux et volubile qui décide de l''accompagner dans son voyage. Traqué par des forces obscures, Guts tente de devenir maître de son destin pour regagner sa liberté et accomplir sa vengeance...', 18, 'http://localhost:3000/images/9782344020685', 1),
  ('Spy X Family', 'Twilight, le plus grand espion du monde, doit pour sa nouvelle mission créer une famille de toutes pièces afin de pouvoir s''introduire dans la plus prestigieuse école de l''aristocratie. Totalement dépourvu d''expérience familiale, il va adopter une petite fille en ignorant qu''elle est télépathe, et s''associer à une jeune femme timide, sans se douter qu''elle est une redoutable tueuse à gages. Ce trio atypique va devoir composer pour passer inaperçu, tout en découvrant les vraies valeurs d''une famille unie et aimante.', 16, 'http://localhost:3000/images/9782380710243', 2);
 
-- Associer les articles aux mangas dans la table de relation
INSERT INTO "manga_has_article" ("manga_code_isbn", "article_id")
VALUES
  ('9782368529904', (SELECT "id" FROM "article" WHERE "title" = 'Fullmetal Alchemist Perfect Tome 1')),
  ('9782871294146', (SELECT "id" FROM "article" WHERE "title" = 'Naruto Tome 1')),
  ('9782871294177', (SELECT "id" FROM "article" WHERE "title" = 'Naruto Tome 2')),
  ('9782871294276', (SELECT "id" FROM "article" WHERE "title" = 'Naruto Tome 3')),
  ('9782871294412', (SELECT "id" FROM "article" WHERE "title" = 'Naruto Tome 4')),
  ('9782871294917', (SELECT "id" FROM "article" WHERE "title" = 'Naruto Tome 5')),
  ('9782871292661', (SELECT "id" FROM "article" WHERE "title" = 'Hunter X Hunter Tome 1')),
  ('9782871292678', (SELECT "id" FROM "article" WHERE "title" = 'Hunter X Hunter Tome 2')),
  ('9782871292685', (SELECT "id" FROM "article" WHERE "title" = 'Hunter X Hunter Tome 3')),
  ('9782871292692', (SELECT "id" FROM "article" WHERE "title" = 'Hunter X Hunter Tome 4')),
  ('9782871292708', (SELECT "id" FROM "article" WHERE "title" = 'Hunter X Hunter Tome 5')),
  ('9782505000327', (SELECT "id" FROM "article" WHERE "title" = 'Death Note Tome 1')),
  ('9782915513585', (SELECT "id" FROM "article" WHERE "title" = 'Ubel Blatt Tome 0')),
  ('9782723455862', (SELECT "id" FROM "article" WHERE "title" = 'Reborn !')),
  ('9782505009993', (SELECT "id" FROM "article" WHERE "title" = 'Monster Intégrale')),
  ('9782811679811', (SELECT "id" FROM "article" WHERE "title" = 'L''attaque des titans')),
  ('9782344020685', (SELECT "id" FROM "article" WHERE "title" = 'Berserk')),
  ('9782380710243', (SELECT "id" FROM "article" WHERE "title" = 'Spy X Family')); 