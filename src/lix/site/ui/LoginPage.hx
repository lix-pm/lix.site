package lix.site.ui;

import lix.site.data.*;
import haxe.Json;
import haxe.crypto.Base64;

class LoginPage extends coconut.ui.View {
	@:attr var app:AppData;
	
	function render() '<div/>';
	
	override function afterInit(e) {
		var auth = new CognitoAuth();
		
		auth.userhandler = {
			onSuccess: function(session) {
				app.user.id = switch try session.idToken.payload.sub catch(e:Dynamic) null {
					case null: try Json.parse(Base64.decode(session.idToken.jwtToken.split('.')[1]).toString()).sub catch(e:Dynamic) null;
					case v: v;
				}
				// TODO: store redirect url in local storage before initializing the login sequence
				spectatory.Location.replace('/');
			},
			onFailure: function(result) trace(result),
		}
		
		auth.parseUrl();
	}
}