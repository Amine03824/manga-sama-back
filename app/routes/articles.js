// Import d'express et du router
const express = require("express");
const router = express.Router();

// Import du controleur
const articleController = require("../controllers/articleController");

// Import du middleware d'authentification
const authenticationMiddleware = require("../middlewares/authenticationMiddleware");

// Routes correspondant aux annonces
router
  .route("/")
  .get(articleController.getAllArticles)
  .post(authenticationMiddleware, articleController.createOneArticle);

// Routes correspondant à une annonce spécifique
router
  .route("/:id")
  .get(articleController.getOneArticleById)
  .put(authenticationMiddleware, articleController.modifyOneArticleById)
  .delete(authenticationMiddleware, articleController.removeOneArticleById);

// Export
module.exports = router;
