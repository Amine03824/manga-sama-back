const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: "smtp.ethereal.email",
  port: 587,
  auth: {
    user: "shania34@ethereal.email",
    pass: "1GhzeP96pPdBP4b42v"
  }
});
module.exports = transporter;
