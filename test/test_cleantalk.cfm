<cfscript>

try{
	auth = deserializeJSON( fileRead( expandPath( "credentials.json" ) ) );
} 
catch (any e) {
	throw(
		message = "Unable to open credentials file. Check the file 
		           test/credentials.json exists and that it has a valid entry for 
		           auth_key. The file is git ignored and should only be used for 
		           testing."
	);
}

cleantalk = new cleantalk.cleantalk(auth_key=auth.auth_key);

data = cleantalk.check_message("sender_email":"richard.lawson@jmailservice.com",
	"sender_nickname":"Richard Lawson",
	"message": "Go Live in Search Results by Tomorrow Looking to boost your traffic fast? We can have your campaign live within 24 hours - and you'll start seeing results immediately.
Want a quick overview?");

writeOutput("Allowed: " & yesNoFormat(data.allow) & "<br><br>");
writeDump(data);

</cfscript>