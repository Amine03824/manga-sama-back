const {pool} = require('../config/database');

const articleDataMapper = {
// Récupère tous les Articles de la base de données
  findAllArticles: async () => {
    const sql = "SELECT * FROM Article ORDER BY title ASC";
    const result = await pool.query(sql);
    if (!result.rowCount) {
      throw new Error("Aucun Article trouvé dans la base de données");
    }
    return result.rows;
  },
  // Insère un nouveau Article dans la base de données
  insertOneArticle: async ({
    VALUES}) => 
  {
    const sql = {
      text : "INSERT INTO Article (VALUES) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *;",
      values : [
        VALUES]
    };
    const result = await pool.query(sql);
    if (!result.rowCount) {
      throw new Error("Aucun Article trouvé dans la base de données");
    }
    return result.rows[0];
  },

  // Met à jour les informations d'un Article dans la base de données
  updateOneArticle: async ({
    code_isbn,
    title,
    volume,
    year_publication,
    author,
    description,
    cover_url,
    category_id
  }) => {
    const sql = {
      text: `
    UPDATE Article
    SET
      title = $2,
      volume = $3,
      year_publication = $4,
      author = $5,
      description = $6,
      cover_url = $7,
      category_id = $8
    WHERE
      code_isbn = $1
    RETURNING *;
  `,
      values: [
        code_isbn,
        title,
        volume,
        year_publication,
        author,
        description,
        cover_url,
        category_id
      ]
    };

    const result = await pool.query(sql);

    if (!result.rowCount) {
      throw new Error("Aucun Article trouvé pour la mise à jour dans la base de données");
    }

    return result.rows[0];
  },


  // Récupère un Article par son code isbn
  findOneArticleById: async (code_isbn) => {
    const sql = {
      text: "SELECT * FROM Article WHERE code_isbn = $1",
      values: [code_isbn]
    };
    const result = await pool.query(sql);
    if (!result.rowCount) {
      throw new Error("Aucun Article correspondant dans la base de données");
    }
    return result.rows[0];
  },

  // Supprime un Article par son code isbn
  deleteOneArticleById: async (code_isbn) => {
    const sql = {
      text: "DELETE FROM Article WHERE code_isbn = $1",
      values: [code_isbn]
    };
    const result = await pool.query(sql);
    if (result.rowCount === 1) {
      return { success: true };
    } else {
      console.log(result);
      console.log("Aucun Article correspondant dans la base de données");

    }
  }
};
module.exports = articleDataMapper;
