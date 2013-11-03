package hxapp.hnd;
class BenchDocpad {
	private static var templ=App.docpadEjsTemplate("hxapp/hnd/bench.ejs", "Tratata site");
	public static function handler(req:Dynamic, resp:Dynamic, next:Dynamic):Void {
		resp.end(
			templ( { text: "Hello World!!! Hello World!!! Hello World!!! Hello World!!! <b>Hello World!!!</b> Hello World!!!" } )
		);
	}
}