package hxapp.hnd;
class Worker {
	private static var templ=App.docpadEjsTemplate("hxapp/hnd/worker.ejs");
	public static function handler(req:Dynamic, resp:Dynamic, next:Dynamic):Void {
		resp.end(
			templ( { text: 'Worker # ${App.cluster.worker.id} PID ${App.cluster.worker.process.pid}' } )
		);
	}
}