<cfscript>

data["pass"] = true;

try{
	auth = deserializeJSON( fileRead( getCanonicalPath( getDirectoryFromPath( getCurrentTemplatePath() ) & "/credentials.json" ) ) );
} 
catch (any e) {
	data["message"] = "Unable to open credentials file. Check the file test/credentials.json exists and that it has a valid entry for auth_key. The file is git ignored and should only be used for testing."
	data.pass = false;
}

if (data.pass) {
	cleantalk = new cleantalk.cleantalk(auth_key=auth.auth_key);

	messages = [
		{"sender_email":"richard.lawson@jmailservice.com",
		"sender_nickname":"Richard Lawson",
	 	"message": "Go Live in Search Results by Tomorrow Looking to boost your traffic fast? We can have your campaign live within 24 hours - and you'll start seeing results immediately.
		Want a quick overview?",
		"pass"=false},
		{
			"sender_email":"tom@clik.com",
			"sender_nickname":"Thomas Peer",
			"message": "cbxcbxz",
			"subject": "xzcbx xcv ffd sdfg",
			"pass"=true
		}

	];

	for (message in messages) {
		check = cleantalk.check_message(argumentCollection = message);
		if ((! message.pass) && check.allow)	 {
			data.pass = false;
			data["message"] = "Invalid message was passed";
			data["check"] = check;
		}
		else if (message.pass && (! check.allow))	 {
			data.pass = false;
			data["message"] = "Valid message was failed";
			data["check"] = check;
		}
	}
}

content reset="true" type="application/json;charset=utf-8";
writeOutput( serializeJSON( data ) );

</cfscript>