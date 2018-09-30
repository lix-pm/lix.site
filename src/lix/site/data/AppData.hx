package lix.site.data;

import coconut.router.*;
import lix.site.data.Route;

class AppData implements coconut.data.Model {
	@:constant var user:UserData = @byDefault new UserData();
	
	@:constant var router:BrowserRouter<Route> = new BrowserRouter({
		routeToLocation: RouteTools.toUrl,
		locationToRoute: RouteTools.fromUrl,
	});
}