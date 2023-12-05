// Import d'express et du router
const express = require("express");
const router = express.Router();

// Import du controlleur
const mangaController = require('../controllers/mangaController');

// Routes correspondant aux mangas
router.route('/')
  .get(mangaController.getAllMangas)
  .post(mangaController.createOneManga);

// Route d'API pour ajouter un manga en base de données
router.route('/:isbn')
  .post(mangaController.getMangaInfos);

// Routes correspondant à un manga spécifique
router.route('/:id')
  .get(mangaController.getOneMangaById)
  .delete(mangaController.removeOneMangaById); 

// // Routes correspondant à la mise à jour d'un manga spécifique
// // Pour son titre
// router.patch('/category/:id/title',mangaController.modifyOneMangaTitleById);

// // Pour son numéro de volume
// router.patch('/category/:id/volume',mangaController.modifyOneMangaVolumeNumberById);

// // Pour son année de publication
// router.patch('/category/:id/date', mangaController.modifyOneMangaYearOfPublicationById);

// // Pour son auteur
// router.patch('/category/:id/author',mangaController.modifyOneMangaAuthorById);

// // Pour sa description
// router.patch('/category/:id/description', mangaController.modifyOneMangaDescriptionById);

// // Pour l'adresse de sa couverture
// router.patch('/category/:id/cover',mangaController.modifyOneMangaCoverUrlById);

// Export
module.exports = router;
