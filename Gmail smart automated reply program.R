# Let's automate a friendly reply to an email.

# Installing and loading the sendmailR package
if (!requireNamespace("sendmailR", quietly = TRUE)) {
  install.packages("sendmailR")
}
library(sendmailR)

# Installing and loading the gmailr package
if (!requireNamespace("gmailr", quietly = TRUE)) {
  install.packages("gmailr")
}
library(gmailr)

# Function to get the subject of the received email
get_subject_of_received_email <- function(sender_email) {
  # Using gmailr to fetch the subject of the most recent email from the sender
  subject <- gmailr::unread(query = sprintf("from:%s in:inbox", sender_email), format = "dataframe")$subject[1]
  
  # If no subject is retrieved, provide a default subject
  if (is.na(subject)) {
    subject <- "Unknown Subject"
  }
  
  return(subject)
}

my_email <- "arjunthakur99914@gmail.com"

sender_email <- "sender@example.com"  # sender's email address

# Using the custom function to dynamically extract the subject of the received email
received_subject <- get_subject_of_received_email(sender_email)

#Crafting a subject line for replying
subject <- sprintf("Re: %s", received_subject)

# Writing the body of the message
body <- sprintf("Hey,\n\nI hope this finds you well. I'm currently knee-deep in a project, so my response might take a bit. I'll loop back to you ASAP regarding \"%s\".\n\nCheers,\nArjun Thakur\n\nDisclaimer: This email is super confidential. If you're not the intended recipient, let me know, and delete it, please. Thanks!", received_subject)

sendmail(from = my_email, to = sender_email, subject = subject, msg = body, control = list(smtpServer = "your-smtp-server"))

# Checking if we sent the message to receiver
cat("Automated reply sent to", sender_email, ":\nSubject:", subject, "\n\n", body, "\n")
