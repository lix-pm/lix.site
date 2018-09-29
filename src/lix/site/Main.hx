package lix.site;

import js.Browser.*;

class Main extends coconut.ui.View {
	static function main() {
		trace(lix.site.util.Macro.getBuildDate());
		trace(lix.site.util.Macro.getGitSha());
		document.body.appendChild(new Main({}).toElement());
	}
	
	function render() '
		<h1>Lix</h1>
	';
}