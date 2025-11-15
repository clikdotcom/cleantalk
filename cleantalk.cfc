component {

	public cleantalk function init(required string auth_key) {
		variables.auth_key = arguments.auth_key;
		variables.api = "https://moderate.cleantalk.org/api2.0";
		return this;
	}

	public struct function check_message(
		required string  sender_email,
		required string  message,
				 string  referrer,
				 string  user_agent,
				 string  sender_nickname,
				 string  sender_ip,
				 numeric submit_time
		) localmode=true {

		jsonData = {
			"auth_key"     = variables.auth_key,
			"sender_email" = arguments.sender_email,
			"message"      = arguments.message,
		}


		for (field in ["sender_nickname","sender_ip","submit_time"]) {
			if ( arguments.keyExists( field ) ) {
				jsonData["#field#"] = arguments[field];
			}
		}

		for (field in ["referrer","user_agent"]) {
			if ( arguments.keyExists( field ) ) {
				StructAppend(jsonData,{"sender_info"={}},false);
				jsonData.sender_info["#field#"] = arguments[field];
			}
		}

		try {

			http method="post" 
				url=variables.api
				result="apiResponse" 
				timeout="30"
			{
				// Add JSON header
				httpparam 
					type="header" 
					name="Content-Type" 
					value="application/json";

				// Add body
				httpparam 
					type="body" 
					value=serializeJSON(jsonData);
			}

		
			res = deserializeJSON(apiResponse.filecontent);

			if (! res.account_status) {
				throw(message="CleanTalk account details invalid",
					detail="The auth_key supplied for clean talk is invalid.");
			}

		}
		catch (any e) {
			local.extendedinfo = {"error"=e,"jsonData"=jsonData};
			if ( isDefined(apiResponse.filecontent) ) {
				local.extendedinfo["filecontent"] = apiResponse.filecontent;
			}
			throw(
				extendedinfo = SerializeJSON(local.extendedinfo),
				message      = "Error making api call to CleanTalk:" & e.message, 
				detail       = e.detail
			);
		}

		return res;

	}


}