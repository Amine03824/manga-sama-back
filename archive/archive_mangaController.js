  // Modifie le titre d'un manga par son code isbn
  modifyOneMangaTitleById: async (request, response) => {
    try {
      const { code_isbn, title } = request.body;

      // Vérifie la présence de tous les paramètres nécessaires dans le corps de la requête
      if (!code_isbn || !title) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaTitleById({
        code_isbn,
        title
      });

      if (modifiedManga) {
        // La modification s'est bien déroulée
        return response.json({
          status: 201,
          success: true,
          message: "Le manga a été modifié avec succès",
          manga: modifiedManga
        });
      } else {
        // Aucune ligne affectée, la modification n'a pas été effectuée
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été modifié"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },

  // Modifie le numéro de volume d'un manga par son code isbn
  modifyOneMangaVolumeNumberById: async (request, response) => {
    try {
      const { code_isbn, newVolumeNumber } = request.body;

      if (!code_isbn || !newVolumeNumber) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaVolumeNumberById(
        newVolumeNumber,
        code_isbn
      );

      if (modifiedManga) {
        return response.json({
          status: 201,
          success: true,
          message: "Le numéro de volume du manga a été mis à jour avec succès",
          manga: modifiedManga
        });
      } else {
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été mis à jour"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },

  // Modifie l'année de publication d'un manga par son code isbn
  modifyOneMangaYearOfPublicationById: async (request, response) => {
    try {
      const { code_isbn, newYearOfPublication } = request.body;

      if (!code_isbn || !newYearOfPublication) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaYearOfPublicationById(
        newYearOfPublication,
        code_isbn
      );

      if (modifiedManga) {
        return response.json({
          status: 201,
          success: true,
          message:
            "L'année de publication du manga a été mise à jour avec succès",
          manga: modifiedManga
        });
      } else {
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été mis à jour"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },

  // Modifie l'auteur d'un manga par son code isbn
  modifyOneMangaAuthorById: async (request, response) => {
    try {
      const { code_isbn, newAuthor } = request.body;

      if (!code_isbn || !newAuthor) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaAuthorById(
        newAuthor,
        code_isbn
      );

      if (modifiedManga) {
        return response.json({
          status: 201,
          success: true,
          message: "L'auteur du manga a été mis à jour avec succès",
          manga: modifiedManga
        });
      } else {
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été mis à jour"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },

  // Modifie la description d'un manga par son code isbn
  modifyOneMangaDescriptionById: async (request, response) => {
    try {
      const { code_isbn, newDescription } = request.body;

      if (!code_isbn || !newDescription) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaDescriptionById(
        newDescription,
        code_isbn
      );

      if (modifiedManga) {
        return response.json({
          status: 201,
          success: true,
          message: "La description du manga a été mise à jour avec succès",
          manga: modifiedManga
        });
      } else {
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été mis à jour"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },

  // Modifie l'URL de couverture d'un manga par son code isbn
  modifyOneMangaCoverUrlById: async (request, response) => {
    try {
      const { code_isbn, newCoverUrl } = request.body;

      if (!code_isbn || !newCoverUrl) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaCoverUrlById(
        newCoverUrl,
        code_isbn
      );

      if (modifiedManga) {
        return response.json({
          status: 201,
          success: true,
          message: "L'URL de couverture du manga a été mise à jour avec succès",
          manga: modifiedManga
        });
      } else {
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été mis à jour"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },


  // Modifie la catégorie d'un manga par son code ISBN
  modifyOneMangaCategoryById: async (request, response) => {
    try {
      const { code_isbn, newCategory } = request.body;

      if (!code_isbn || !newCategory) {
        return response.json({
          status: 400,
          error: "Paramètre manquant dans le corps de la requête HTTP"
        });
      }

      const modifiedManga = await mangaDataMapper.updateOneMangaCategoryById(
        newCategory,
        code_isbn
      );

      if (modifiedManga) {
        return response.json({
          status: 201,
          success: true,
          message: "La catégorie du manga a été mise à jour avec succès",
          manga: modifiedManga
        });
      } else {
        return response.json({
          status: 200,
          success: false,
          message: "Aucun manga n'a été mis à jour"
        });
      }
    } catch (error) {
      console.log(error);
      return response.json({
        status: 500,
        success: false,
        error: {
          message: error.toString()
        }
      });
    }
  },