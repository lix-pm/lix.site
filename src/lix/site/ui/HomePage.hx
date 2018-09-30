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
					<span>Logged in as ${id}</span>
					<button onclick=${logout}>Logout</button>
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