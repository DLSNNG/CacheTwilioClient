/// Cache implementation of the Twilio REST Client
Class Twilio.Rest.Client Extends %RegisteredObject
{

/// Twilio's REST API
Property server As %String [ InitialExpression = "api.twilio.com" ];

/// Twilio Account SID found on https://www.twilio.com/console
Property Sid As %String;

/// Twilio Auth Token found on https://www.twilio.com/console
Property AuthToken As %String;

/// The name of the SSLConfig to use with each request (Required for HTTPS)
Property SSLConfig As %String;

Method %OnNew(pSid As %String, pAuthToken As %String, pSSLConfig As %String) As %Status
{
	Set ..Sid = pSid
	Set ..AuthToken = pAuthToken
	Set ..SSLConfig = pSSLConfig
	Quit $$$OK
}

/// Make a call using the Twilio REST API.
/// pFrom should be a registered Twilio Phone Number. It needs to follow Twilio's formatting.
/// pTo should be the phone number you would like to call. It needs to follow Twilio's formatting.
/// pUrl is the URL where your TwiML markup resides. Use the TwiML to dictate how the phone call should
/// be handled.
Method Call(pFrom As %String, pTo As %String, pUrl As %String = "") As %String
{
	Set httpRequest = ##class(%Net.HttpRequest).%New()
	Set httpRequest.Server = ..server
	Set httpRequest.Https = 1 // Twilio requires HTTPS
	Set httpRequest.SSLConfiguration = ..SSLConfig // Pass in SSL Configuration to use with HTTPS request
	// Determine endpoint we will be posting to
	Set endpoint = "/2010-04-01/Accounts/"_..Sid_"/Calls"
	// Add Credentials to request
	Set httpRequest.Username = ..Sid
	Set httpRequest.Password = ..AuthToken
	// Add form data to http request
	Do httpRequest.InsertFormData("From", pFrom)
	Do httpRequest.InsertFormData("To", pTo)
	If "" '= pUrl {
		Do httpRequest.InsertFormData("Url", pUrl)
	}
	// Post request to server
	Set status = httpRequest.Post(endpoint)
	If $$$ISERR(status) { Quit status }
	Set responseString = httpRequest.HttpResponse.Data.Read()
	Quit responseString
}

}
