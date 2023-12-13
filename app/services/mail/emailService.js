const transporter = require('./nodemailer');

async function sendConfirmationEmail(toEmail) {
  const mailOptions = {
    from: 'ruthie52@ethereal.email',
    to: toEmail,
    subject: '(づ｡◕‿‿◕｡)づ Confirmation d\'inscription',
    text: 'Bienvenue sur la plateforme Manga-Sama! 🍣 Votre inscription est confirmée.',
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log('E-mail de confirmation envoyé avec succès.');
  } catch (error) {
    console.error('Erreur lors de l\'envoi de l\'e-mail de confirmation:', error);
    throw error;
  }
}

module.exports = {
  sendConfirmationEmail,
};
