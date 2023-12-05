const mangaDataMapper = require("../dataMappers/mangaDataMapper");
const mangaService = require("../services/mangaAPI");

const mangaController = {
  // Récupère tous les mangas de la base de données
  getAllMangas: async (request, response, next) => {
    try {
      const mangas = await mangaDataMapper.findAllMangas();
      if (!mangas) {
        return next();
      }

      response.json({
        status: 200,
        mangas
      });
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

  // Crée une entrée dans la base de données à partir d'un ISBN
  getMangaInfos: async (request, response) => {
    try {
      const { code_isbn } = request.body;

      // Vérifie la présence de tous les paramètres nécessaires dans le corps de la requête
      if (!code_isbn) {
        return response.json({
          status: 400,
          error: "L'ISBN est manquant."
        });
      }

      try {
        // Récupère les informations du manga
        const mangaInfo = await mangaService.getMangaInfo(code_isbn);

        if (mangaInfo) {
          // Insère les informations du manga en base de données
          const insertedManga = await mangaDataMapper.insertOneManga({
            code_isbn,
            title: mangaInfo.title,
            volume: mangaInfo.volume,
            year_publication: mangaInfo.year_publication,
            author: mangaInfo.author,
            description: mangaInfo.description,
            cover_url: mangaInfo.cover_url,
            category_id: mangaInfo.category_id
          });

          if (insertedManga) {
            // La création s'est bien déroulée
            console.log("Le manga a été créé avec succès");
            return response.json({
              status: 201,
              success: true,
              message: "Le manga a été créé avec succès",
              manga: insertedManga
            });
          } else {
            // Aucune ligne affectée, la création n'a pas été effectuée
            return response.json({
              status: 200,
              success: false,
              message:
                "Aucun manga n'a été créé, peut-être que le manga existe déjà"
            });
          }
        } else {
          // MangaInfo est null, indique un problème lors de la récupération des informations du manga
          return response.json({
            status: 404,
            success: false,
            message: "Les informations du manga n'ont pas pu être récupérées."
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

  // TODO! : Lire infos sur la méthode HTTP "PUT"
  // TODO  : décider de la logique de création d'un manga, automatisé api ou fallback utilisateur à la main et de comment arrivent les informations depuis l'api (un truc genre "apimanga(createonemanga)" )
  // Crée un nouveau manga dans la base de données
  createOneManga: async (request, response) => {
    try {
      const {
        code_isbn,
        title,
        volume,
        year_publication,
        author,
        description,
        cover_url,
        category_id
      } = request.body;

      // Vérifie la présence de tous les paramètres nécessaires dans le corps de la requête
      if (
        !code_isbn ||
        !title ||
        !volume ||
        !year_publication ||
        !author ||
        !description ||
        !cover_url ||
        !category_id
      ) {
        return response.status(400).json({ error: "Missing body parameter" });
      }
      const newManga = await mangaDataMapper.insertOneManga({
        code_isbn,
        title,
        volume,
        year_publication,
        author,
        description,
        cover_url,
        category_id
      });

      if (newManga) {
        // La création s'est bien déroulée
        console.log("Le manga a été créé avec succès");
        return response.json({
          status: 201,
          success: true,
          message: "Le manga a été créé avec succès",
          manga: newManga
        });
      } else {
        // Aucune ligne affectée, la création n'a pas été effectuée
        return response.json({
          status: 200,
          success: false,
          message:
            "Aucun manga n'a été créé, peut-être que le manga existe déjà"
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

  // Récupère un manga par son code isbn
  getOneMangaById: async (request, response) => {
    const { code_isbn } = request.params;
    try {
      const manga = await mangaDataMapper.findOneMangaById(code_isbn);
      if (!manga) {
        // Aucun manga trouvé, renvoyer une réponse 404 Not Found
        return response.json({
          status: 404,
          success: false,
          message: "Aucun manga trouvé avec le code isbn spécifié"
        });
      }
      return response.json({
        status: 200,
        success: true,
        manga
      });
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

  // TODO!: A rendre dynamique si le mangaDataMapper est rendu dynamique aussi
  // modifyOneMangaById : async (request, response) => {
  //   try {
  //     const {
  //       code_isbn,
  //       title,
  //       volume,
  //       year_publication,
  //       author,
  //       description,
  //       cover_url,
  //       category_id } = request.body;

  //     if (!code_isbn || !title || !author || !description || !cover_url) {
  //       return response.json({
  //         status: 400,
  //         error: "Paramètre manquant dans le corps de la requête HTTP"
  //       });
  //     }

  //     if (volume && typeof volume !== "number") {
  //       return response.json({
  //         "error": "Type invalide : le tome doit être un nombre"}
  //       );}

  //     if (year_publication && typeof year_publication !== "number") {
  //       return response.json({
  //         "error": "Type invalide : l'année de publication doit être un nombre"}
  //       );}

  //     const modifiedManga = await mangaDataMapper.insertOneManga({
  //       code_isbn,
  //       title,
  //       volume,
  //       year_publication,
  //       author,
  //       description,
  //       cover_url,
  //       category_id,
  //     });

  //     if (modifiedManga) {
  //     // La modification s'est bien déroulée
  //       return response.json({
  //         status: 201,
  //         success: true,
  //         message: 'Le manga a été modifié avec succès',
  //         manga: modifiedManga,
  //       });

  //     } else {
  //       // Aucune ligne affectée, la modification n'a pas été effectuée
  //       return response.json({
  //         status : 200,
  //         success: false,
  //         message: "Aucun manga n'a été modifié",
  //       });

  //     }

  //   }catch (error) {
  //     console.log(error);
  //     return response.json({
  //       status : 500,
  //       success: false,
  //       error: {
  //         message : error.toString()
  //       }
  //     });
  //   }
  // },

  removeOneMangaById: async (request, response) => {
    const { code_isbn } = request.params;
    try {
      const manga = await mangaDataMapper.deleteOneMangaById(code_isbn);
      if (!manga) {
        // Aucun manga trouvé, renvoyer une réponse 404 Not Found
        return response.json({
          status: 404,
          success: false,
          message: "Aucun manga trouvé avec le code isbn spécifié"
        });
      }
      return response.json({
        status: 200,
        success: true,
        message: "Manga supprimé avec succès"
      });
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
  }
};

module.exports = mangaController;
