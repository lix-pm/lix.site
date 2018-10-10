package lix.site.ui;

import lix.site.data.*;

class HomePage extends coconut.ui.View {
	@:attr var app:AppData;
	
	function render() '
		<div>
			<h1>Lix</h1>
			<switch ${app.user.id}>
				<case ${null}>
					<button onclick=${login}>Login</button>
				<case ${id}>
					<div>Logged in as ${id}</div>
					<pre>${haxe.Json.stringify(app.user.data, '  ')}</pre>
					<div><button onclick=${logout}>Logout</button></div>
			</switch>
		</div>
	';
	
	function login() {
		var auth = new CognitoAuth();
		auth.getSession();
	}
	
	function logout() {
		var auth = new CognitoAuth();
		auth.signOut();
	}
}