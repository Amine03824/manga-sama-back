// Import d'express et du router
const express = require("express");
const router = express.Router();

// Import du controlleur
const conditionController = require("../controllers/conditionController");

// Import du middleware d'authentification
const authenticationMiddleware = require("../middlewares/authenticationMiddleware");

// Routes correspondant à l'état des mangas
router
  .route("/")
  .get(conditionController.getAllConditions)
  .post(authenticationMiddleware, conditionController.createOneCondition);

// Routes correspondant à un état spécifique
router
  .route("/:id")
  .get(authenticationMiddleware, conditionController.getOneConditionById)
  .patch(authenticationMiddleware, conditionController.modifyOneConditionById)
  .delete(authenticationMiddleware, conditionController.removeOneConditionById);

// Export
module.exports = router;
