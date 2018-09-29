package lix.site.data;

import tink.url.*;
import tink.Url;
import tink.QueryString.*;

using StringTools;

enum Route {
	Home;
	
	Register;
	Login;
	
	NotFound(path:String);
	Error(options:{@:optional final message:String;});
}

class RouteTools {
	public static function toUrl(route:Route):Url {
		return switch route {
			case Home: '/';
			
			case Register: '/register';
			case Login: '/login';
			
			case NotFound(path): path;
			case Error(options): '/error?' + build(options);
		}
	}
	
	public static function fromUrl(url:Url):Route {
		return switch url.path.parts().toStringArray() {
			case []: Home;
			
			case ['register']: Register;
			case ['login']: Login;
			
			case ['error']: tryParse(Error.bind(parse(url.query)));
			case _: NotFound(url);
		}
	}
	
	static function tryParse(f:Void->Route)
		return try f() catch(e:Dynamic) Error(e);
}