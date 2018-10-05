package lix.site.data;

import lix.util.Config.*;
import js.Browser.*;

@:forward
abstract CognitoAuth(aws.cognito.CognitoAuth) {
	public function new() {
		this = new aws.cognito.CognitoAuth({
			ClientId: 'fvrf50i7h5od9nr1bq4pefcg3',
			AppWebDomain: 'login.lix.pm',
			RedirectUriSignIn: '$SITE_URL/login',
			RedirectUriSignOut: SITE_URL,
			TokenScopesArray: ['openid'],
			UserPoolId: 'us-east-2_qNnxj1mU1',
		});
	}
	
	public inline function parseUrl()
		return this.parseCognitoWebResponse(window.location.href);
}