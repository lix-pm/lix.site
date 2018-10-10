package lix.site;

import js.Browser.*;
import lix.site.data.*;
import lix.site.util.*;
import lix.site.ui.*;
import coconut.router.ui.BrowserRouter as Router;

class Main extends coconut.ui.View {
	static function main() {
		trace(Macro.getBuildDate());
		trace(Macro.getGitSha());
		
		trace(new CognitoAuth().getSignInUserSession().idToken.payload);
		trace(new CognitoAuth().getSignInUserSession().accessToken.payload);
		
		var data = new AppData({
			user: new UserData({
				id: try new CognitoAuth().getSignInUserSession().idToken.payload.sub catch(e:Dynamic) null,
			}),
		});
		
		document.body.appendChild(new Main({app: data}).toElement());
		
		var remote = new tink.web.proxy.Remote<lix.api.Root>(null, null);
	}
	
	@:attr var app:AppData;
	
	function render() '
		<Router router=${app.router}>
			<switch ${app.router.route}>
				<case ${Home}>
					<HomePage ${...this}/>
				<case ${Register}>
					<h1>Register</h1>
				<case ${Login}>
					<LoginPage ${...this}/>
				<case ${NotFound(path)}>
					<span>Not Found: ${path}</span>
				<case ${Error(o)}>
					<span>${o.message}</span>
			</switch>
		</Router>
	';
}