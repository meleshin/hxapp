package hxapp.hnd;
class BenchEco {
	private static var templ=App.clearEcoTemplate("hxapp/hnd/bench.eco", "Tratata site");
	public static function handler(req:Dynamic, resp:Dynamic, next:Dynamic):Void {
		resp.end(
			templ( { text: "Hello World!!! Hello World!!! Hello World!!! Hello World!!! <b>Hello World!!!</b> Hello World!!!" } )
		);
	}
}