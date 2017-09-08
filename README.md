# Setup
1. Create an account on [twilio](https://twilio.com)
2. Add a new phone number under the [Manage Numbers Page](https://www.twilio.com/console/phone-numbers/incoming). This will be the number you call from.
3. Verify a new caller ID under the [Verified Caller IDs Page](https://www.twilio.com/console/phone-numbers/verified). This will be the number you call to. If you have a trial account, you are only able to make calls to verified numbers.
4. Fork this Repo and place the *Twilio.Rest.Client.xml* file on your Cache Server. Then use Cache Studio's Import tool (located under Tools > Import) to import Twilio.Rest.Client.xml. (Alternatively you could just copy the code from Twilio.Rest.Client.cls since it's just one file)
5. Make sure you have an SSL Configuration defined. This can be done through the Cache Management Portal under System Administration > Security > SSL/TLS Configurations.

# Usage
1. Instantiate a new Twilio Client using the Account SID and Auth Token found [here](https://www.twilio.com/console)
```
	Set sid = "your_sid"
	Set token = "your_token"
	Set sslConfig = "name_of_your_ssl_config" //Step 5 of Setup
	Set twilio = ##class(Twilio.Rest.Client).%New(sid, token, sslConfig)

```
2. Make a call
```
	Set from = "+18001234567" 				// Twilio phone from step 2 of Setup
	Set to = "+18008675309" 				// Verified caller ID from step 3 of Setup
	Set url = "http://demo.twilio.com/docs/voice.xml" 	// web page containing TwiML instructions
	Set response = twilio.Call(from, to, url)
	// optionally read/handle response
```

Twilio determines how the call is handled based on XML instructions called TwiML. You can see the instructions used in the above example by visiting http://demo.twilio.com/docs/voice.xml. Check out the [TwiML docs](https://www.twilio.com/docs/api/twiml) to learn more. 

To change how the call is handled, create your own webpage and have it return a set of TwiML instructions. Then pass that url to the Twilio.Rest.Client instead.

Happy coding!