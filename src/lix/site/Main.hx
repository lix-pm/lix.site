package lix.site;

import js.Browser.*;
import lix.site.data.*;
import lix.site.util.*;
import coconut.router.ui.BrowserRouter as Router;

class Main extends coconut.ui.View {
	static function main() {
		trace(Macro.getBuildDate());
		trace(Macro.getGitSha());
		
		document.body.appendChild(new Main({app: new AppData({})}).toElement());
		
		var remote = new tink.web.proxy.Remote<lix.api.Root>(null, null);
	}
	
	@:attr var app:AppData;
	
	function render() '
		<Router router=${app.router}>
			<switch ${app.router.route}>
				<case ${Home}>
					<h1>Lix</h1>
				<case ${Register}>
					<h1>Register</h1>
				<case ${Login}>
					<h1>Login</h1>
				<case ${NotFound(path)}>
					<span>Not Found: ${path}</span>
				<case ${Error(o)}>
					<span>${o.message}</span>
			</switch>
		</Router>
	';
}