package com.sfa.util;

import java.util.Properties;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.xml.bind.DatatypeConverter;

public class PushMail2 {
	
	
	  private static final String KEY_ENV_VARIABLE = "HZ3uUlEmNV7IZoi4GArdvyRV9STAyeeoIBPANxpX"; // Put your AWS secret access key in this environment variable.
      private static final String MESSAGE = "SendRawEmail"; // Used to generate the HMAC signature. Do not modify.
      private static final byte VERSION =  0x02; // Version number. Do not modify.



    // Replace recipient@example.com with a "To" address. If your account 
    // is still in the sandbox, this address must be verified.
    static final String FROM = "leehacksue@gmail.com";
	
    // Replace sender@example.com with your "From" address. 
    // This address must be verified.
    static final String TO = "leehacksue@naver.com";
    
    // Replace smtp_username with your Amazon SES SMTP user name.
    static final String SMTP_USERNAME = "AKIAJ2V2AGTFJ4AJHFUA";
    
    // Replace smtp_password with your Amazon SES SMTP password.
    static final String SMTP_PASSWORD = "AvNYAjfxbVBKQ0DlqdMctO2kTBFWJ9Ax9lAEXHIpa0Y7";
    
    // The name of the Configuration Set to use for this message.
    // If you comment out or remove this variable, you will also need to
    // comment out or remove the header on line 65.
    //static final String CONFIGSET = "ConfigSet";
    
    // Amazon SES SMTP host name. This example uses the US West (Oregon) Region.
    static final String HOST = "email-smtp.us-west-2.amazonaws.com";
    
    // The port you will connect to on the Amazon SES SMTP endpoint. 
    static final int PORT = 465;
    
    static final String SUBJECT = "Amazon SES test (SMTP interface accessed using Java)";
    
    static final String BODY = String.join(
    	    System.getProperty("line.separator"),
    	    "<h1>Amazon SES SMTP Email Test</h1>",
    	    "<p>This email was sent with Amazon SES using the ", 
    	    "<a href='https://github.com/javaee/javamail'>Javamail Package</a>",
    	    " for <a href='https://www.java.com'>Java</a>."
    	);
    public void connect()
    {
    	 // Get the AWS secret access key from environment variable AWS_SECRET_ACCESS_KEY.
        String key = System.getenv(KEY_ENV_VARIABLE);         	  
        if (key == null)
        {
           System.out.println("Error: Cannot find environment variable AWS_SECRET_ACCESS_KEY.");  
           System.exit(0);
        }
	    	       	   
        // Create an HMAC-SHA256 key from the raw bytes of the AWS secret access key.
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "HmacSHA256");

        try {         	  
               // Get an HMAC-SHA256 Mac instance and initialize it with the AWS secret access key.
               Mac mac = Mac.getInstance("HmacSHA256");
               mac.init(secretKey);

               // Compute the HMAC signature on the input data bytes.
               byte[] rawSignature = mac.doFinal(MESSAGE.getBytes());

               // Prepend the version number to the signature.
               byte[] rawSignatureWithVersion = new byte[rawSignature.length + 1];               
               byte[] versionArray = {VERSION};                
               System.arraycopy(versionArray, 0, rawSignatureWithVersion, 0, 1);
               System.arraycopy(rawSignature, 0, rawSignatureWithVersion, 1, rawSignature.length);

               // To get the final SMTP password, convert the HMAC signature to base 64.
               String smtpPassword = DatatypeConverter.printBase64Binary(rawSignatureWithVersion);       
               System.out.println(smtpPassword);
        } 
        catch (Exception ex) {
               System.out.println("Error generating SMTP password: " + ex.getMessage());
        }             

    }
	
	public  void push() throws MessagingException
	{
		 // Create a Properties object to contain connection configuration information.
    	Properties props = System.getProperties();
    	props.put("mail.transport.protocol", "smtp");
    	props.put("mail.smtp.port", PORT); 
    	props.put("mail.smtp.ssl.enable", "true");
    	props.put("mail.smtp.auth", "true");

        // Create a Session object to represent a mail session with the specified properties. 
    	Session session = Session.getDefaultInstance(props);

        // Create a message with the specified information. 
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(FROM));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
        msg.setSubject(SUBJECT);
        msg.setContent(BODY,"text/html");
        
        // Add a configuration set header. Comment or delete the 
        // next line if you are not using a configuration set
        //msg.setHeader("X-SES-CONFIGURATION-SET", CONFIGSET);
            
        // Create a transport.
        Transport transport = session.getTransport();
                    
        // Send the message.
        try
        {
            System.out.println("Sending...");
            
            // Connect to Amazon SES using the SMTP username and password you specified above.
            transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
        	
            // Send the email.
            transport.sendMessage(msg, msg.getAllRecipients());
            System.out.println("Email sent!");
        }
        catch (Exception ex) {
            System.out.println("The email was not sent.");
            System.out.println("Error message: " + ex.getMessage());
        }
        finally
        {
            // Close and terminate the connection.
            transport.close();
        }
    }
}
