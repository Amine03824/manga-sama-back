// Import d'express et du router
const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

// Import du middleware d'authentification
const authenticationMiddleware = require("../middlewares/authenticationMiddleware");

// Ajout du Middleware d'authentification sécurisée
router.use(authenticationMiddleware);

// Route d'administrateur pour éditer les privilèges d'un utilisateur spécifique
router.route("/user/:id").put(userController.adminModifyOneUserById);

// Export
module.exports = router;
