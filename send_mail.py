import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication

def send_mail(recipient,title,body):
  # Definir las credenciales
  sender = "jjhuertasbotache3@gmail.com"
  # password = "newEmailPassword"
  password = "dinnqugikxnajksi"

  # Definir los detalles del destinatario
  

  # Crear el mensaje
  message = MIMEMultipart()
  message["From"] = sender
  message["To"] = recipient
  message["Subject"] = title

  # Agregar el cuerpo del mensaje
  message.attach(MIMEText(body, "plain"))


  # Inciar sesión en servidor SMTP de gmail
  server = smtplib.SMTP("smtp.gmail.com", 587)
  server.starttls()
  server.login(sender, password)

  # Enviar correo
  txt = message.as_string()
  server.sendmail(sender, recipient, txt)
  server.quit()

  print("mail sended")
  

# send_mail("jjhuertasbotache@gmail.com","hola","como esta?")