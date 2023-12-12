// Import d'express et du router
const express = require("express");
const router = express.Router();

// Import du controlleur
const categoryController = require("../controllers/categoryController");

// Import du middleware d'authentification
const authenticationMiddleware = require("../middlewares/authenticationMiddleware");

// Routes correspondant aux catégories
router
  .route("/")
  .get(categoryController.getAllCategories)
  .post(authenticationMiddleware, categoryController.createOneCategory);

// Routes correspondant à une catégorie spécifique
router
  .route("/:id")
  .get(categoryController.getOneCategoryById)
  .patch(authenticationMiddleware, categoryController.modifyOneCategoryById)
  .delete(authenticationMiddleware, categoryController.removeOneCategoryById);

// Export
module.exports = router;
