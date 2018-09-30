package lix.site.data;

import lix.util.Config.*;
import js.Browser.*;

@:forward
abstract CognitoAuth(Impl) {
	public function new() {
		this = new Impl({
			ClientId: 'fvrf50i7h5od9nr1bq4pefcg3',
			AppWebDomain: 'lix.auth.us-east-2.amazoncognito.com',
			RedirectUriSignIn: '$SITE_URL/login',
			RedirectUriSignOut: SITE_URL,
			TokenScopesArray: ['openid'],
			UserPoolId: 'us-east-2_qNnxj1mU1',
		});
	}
	
	public inline function parseUrl()
		return this.parseCognitoWebResponse(window.location.href);
}


@:native('AmazonCognitoIdentity.CognitoAuth')
extern class Impl {
	var userhandler:{
		onSuccess:Session->Void,
		onFailure:js.Error->Void,
	}
	function new(config:{});
	function setState(v:String):Void;
	function getSession():Void;
	function useCodeGrantFlow():Void;
	function parseCognitoWebResponse(href:String):Void;
	function getSignInUserSession():Session;
	function signOut():Void;
}

typedef Session = {
	accessToken: {jwtToken:String, payload:AccessTokenPayload},
	idToken: {jwtToken:String, payload:IdTokenPayload},
	refresToken: {refresToken:String},
	state:String,
	tokenScopes: {tokenScopes:Array<String>},
}

typedef AccessTokenPayload = {
	auth_time:Int,
	exp:Int,
	iat:Int,
	// "cognito:groups":Array<String>,
	client_id:String,
	iss:String,
	jti:String,
	scope:String,
	sub:String,
	token_use:String,
	username:String,
	version:Int,
}

typedef IdTokenPayload = {
	auth_time:Int,
	exp:Int,
	iat:Int,
	updated_at:Int,
	email_verified:Bool,
	identities:Array<{
		dateCreated:String,
		issuer:String,
		primary:String,
		providerName:String,
		providerType:String,
		userId:String,
	}>,
	// "cognito:groups": String
	// "cognito:username": String
	at_hash:String,
	aud:String,
	email:String,
	iss:String,
	name:String,
	picture:String,
	profile:String,
	sub:String,
	token_use:String,
	website:String,
}