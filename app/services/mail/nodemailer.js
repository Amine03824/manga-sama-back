const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: 'smtp.ethereal.email',
  port: 587,
  auth: {
    user: 'ruthie52@ethereal.email',
    pass: 'uwabFfMaRFPx7w1kHV'
  }
});
module.exports = transporter;
