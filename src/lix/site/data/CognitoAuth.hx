package lix.site.data;

import lix.util.Config.*;
import js.Browser.*;

using tink.CoreApi;

class CognitoAuth {
	public var result:Promise<Session>;
	public var isSignedIn(get, never):Bool;
	var impl:aws.cognito.CognitoAuth;
	
	public function new() {
		impl = new aws.cognito.CognitoAuth({
			ClientId: 'fvrf50i7h5od9nr1bq4pefcg3',
			AppWebDomain: 'login.lix.pm',
			RedirectUriSignIn: '$SITE_URL/login',
			RedirectUriSignOut: SITE_URL,
			TokenScopesArray: ['openid'],
			UserPoolId: 'us-east-2_qNnxj1mU1',
		});
		
		result = Future.async(function(cb) {
			impl.userhandler = {
				onSuccess: session -> cb(Success({
					idToken: session.idToken.jwtToken,
					accessToken: session.accessToken.jwtToken,
					refreshToken: session.refreshToken.refreshToken,
					scopes: session.tokenScopes.tokenScopes,
				})),
				onFailure: e -> cb(Failure(Error.ofJsError(e))),
			}
		});
	}
	
	public inline function getSignInUserSession() {
		return impl.getSignInUserSession();
	}
	
	public inline function getSession() {
		impl.getSession();
	}
	
	public inline function signOut() {
		impl.signOut();
	}
	
	public inline function parseUrl()
		return impl.parseCognitoWebResponse(window.location.href);
		
	inline function get_isSignedIn() return impl.isUserSignedIn();
}

typedef Session = {
	final idToken:String;
	final accessToken:String;
	final refreshToken:String;
	final scopes:List<String>;
}