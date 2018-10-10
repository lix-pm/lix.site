package lix.site.data;

import tink.http.clients.*;

using tink.CoreApi;

class UserData implements coconut.data.Model {
	@:editable var id:String = @byDefault null;
	@:loaded var data:lix.api.types.User =
		new lix.Remote(new JsClient(), () -> {
			#if (environment == "local")
				'2';
			#else
				var auth = new CognitoAuth();
				auth.getSession();
				auth.result.next(session -> session.idToken);
			#end
		}).me().get();
}