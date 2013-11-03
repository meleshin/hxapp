package hxapp.hnd;
using StringTools;
class BenchMtt {
	private static var templ=App.clearMttTemplate("hxapp/hnd/bench.mtt", "Tratata site");
	public static function handler(req:Dynamic, resp:Dynamic, next:Dynamic):Void {
		resp.end(
			templ( { text: "Hello World!!! Hello World!!! Hello World!!! Hello World!!! <b>Hello World!!!</b> Hello World!!!".htmlEscape() } )
		);
	}
}