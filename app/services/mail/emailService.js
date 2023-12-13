/* eslint-disable no-useless-escape */
const transporter = require('./nodemailer');

const emailService = {
  sendConfirmationEmail: async (toEmail) => {
    const mailOptions = {
      from: 'ruthie52@ethereal.email',
      to: toEmail,
      subject: '(づ｡◕‿‿◕｡)づ Confirmation d\'inscription',
      text: 'Bienvenue sur la plateforme Manga-Sama! 🍣 Votre inscription est confirmée.',
    };
    return sendMailWithLogging(mailOptions, 'E-mail de confirmation envoyé avec succès.');
  },

  sendTransactionBuyerConfirmationEmail: async (buyerEmail, sellerEmail, articleInfos) => {
    const mailOptions = {
      from: 'ruthie52@ethereal.email',
      to: buyerEmail,
      subject: `Le manga "${articleInfos.title}" a été réservé!📚`,
      text: `(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ La transaction est confirmée ✧･: *ヽ(◕ヮ◕ヽ)\
      il ne te reste plus qu'a entrer en contact avec le vendeur 🎌 !\ 
      adresse mail du vendeur : ${sellerEmail}\
      `,
    };
    return sendMailWithLogging(mailOptions, 'E-mail de confirmation d\'achat envoyé avec succès.');
  },

  sendTransactionSellerConfirmationEmail: async (buyerEmail, sellerEmail, articleInfos) => {
    const mailOptions = {
      from: 'ruthie52@ethereal.email',
      to: sellerEmail,
      subject: `Ton manga "${articleInfos.title}" a été acheté!📚`,
      text: `(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ La transaction est confirmée ✧･: *ヽ(◕ヮ◕ヽ)\
      il ne te reste plus qu'a entrer en contact avec l'acheteur 🎌 !\ 
      adresse mail de l'acheteur : ${buyerEmail}\
      `,
    };
    return sendMailWithLogging(mailOptions, 'E-mail de confirmation de vente envoyé avec succès.');
  },
};

// Fonction utilitaire pour l'envoi d'e-mails avec gestion des logs
const sendMailWithLogging = async (mailOptions, successMessage) => {
  try {
    await transporter.sendMail(mailOptions);
    console.log(successMessage);
  } catch (error) {
    console.error(`Erreur lors de l'envoi de l'e-mail :`, error);
    throw error;
  }
};

module.exports = emailService;
