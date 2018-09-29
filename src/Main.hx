package;

import js.Browser.*;

class Main extends coconut.ui.View {
	static function main() {
		document.body.appendChild(new Main({}).toElement());
	}
	
	function render() '
		<h1>Lix</h1>
	';
}