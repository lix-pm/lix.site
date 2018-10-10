package lix.site.ui;

import lix.site.data.*;
import haxe.Json;
import haxe.crypto.Base64;

class LoginPage extends coconut.ui.View {
	@:attr var app:AppData;
	
	function render() '<div/>';
	
	override function afterInit(e) {
		var auth = new CognitoAuth();
		auth.result.handle(function(o) switch o {
			case Success(session): 
				app.user.id = try Json.parse(Base64.decode(session.idToken.split('.')[1]).toString()).sub catch(e:Dynamic) null;
				// TODO: store redirect url in local storage before initializing the login sequence
				spectatory.Location.replace('/');
			case Failure(e):
				trace(e);
		});
		auth.parseUrl();
	}
}