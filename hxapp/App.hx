package hxapp;
import hxapp.hnd.*;
using StringTools;
class App {
	private static function route(app) {
		app.get("/bench", BenchEjs.handler);
		app.get("/bench-ejs", BenchEjs.handler);
		app.get("/bench-mtt", BenchMtt.handler);
		app.get("/bench-eco", BenchEco.handler);
		app.get("/bench-docpad", BenchDocpad.handler);
		app.get("/worker", Worker.handler);
	}
	public static var require(default,null) : String->Dynamic = untyped __js__('require');
	public static var config(default, null) : Dynamic = require("../config");
	public static var http(default, null) : Dynamic = require("http");
	public static var fs(default, null) : Dynamic = require("fs");
	public static var url(default,null) : Dynamic = require("url");
	public static var cluster(default, null) : Dynamic = require("cluster");
	public static var os(default, null) : Dynamic = require("os");
	public static var ejs(default, null) : Dynamic = require("ejs");
	public static var eco(default, null) : Dynamic = require("eco");
	public static var docpad(default, null) : Dynamic = require("docpad");
	public static var express(default, null) : Dynamic = require("express");
	public static var docpadInstance(default, null) : Dynamic = null;
	public static var clearLayoutEjsTemplate(default, null) = compileEjsTemplate("hxapp/layout-clear.ejs");
	public static var clearLayoutMttTemplate(default, null) = compileMttTemplate("hxapp/layout-clear.mtt");
	public static var clearLayoutEcoTemplate(default, null) = compileEcoTemplate("hxapp/layout-clear.eco");
	public static var docpadTemplate(default, null) = compileEjsTemplate("out/layout-app.html");
	static function worker() {
		var app:Dynamic = express();
		var server = http.createServer(app).listen(config.port);
		app.enable('trust proxy');
		route(app);
		var dpConf = {	serverExpress: app,
						serverHttp: server,
						events: {
							writeAfter: function(opts) {
								var m = opts.collection.findOne( { url: "/layout-app" } );
								if (m != null) {
									docpadTemplate = ejs.compile(m.get("contentRendered"));
								}
							}
						}
		}
		docpadInstance = docpad.createInstance({}, function(err){
			if (err != null)  return trace(err.stack);
			docpadInstance.action("generate server watch", dpConf, function(err){
				if (err != null) return trace(err.stack);
			});
		});
	}
	static function main () {
		if (cluster.isMaster) {
			var workers;
			if (config.workers == null) {
				workers = os.cpus().length;
			}else {
				workers = config.workers;
			}
			cluster.on('exit', function(worker, code, signal) {
				var exitCode = worker.process.exitCode;
				trace('Worker ' + worker.process.pid + ' exited ('+exitCode+'). restarting...');
				cluster.fork();
			});
			trace("Forking...");
			for (i in 0...workers){
				cluster.fork();
			}
		}else {
			trace('Starting worker # ${cluster.worker.id} PID ${cluster.worker.process.pid}');
			worker();
		}
	}
	public static function compileEjsTemplate(file:String):Dynamic->String {
		return ejs.compile(fs.readFileSync(file, {encoding:"utf8"}));
	}
	public static function clearEjsTemplate(contentFile:String, ?title:String):Dynamic->String {
		if (title == null) title = config.siteName;
		var contentTemplate = compileEjsTemplate(contentFile);
		return function(opts) {
			var contentStr = contentTemplate(opts);
			return clearLayoutEjsTemplate({title: title, content: contentStr});
		}
	}
	public static function compileMttTemplate(file:String):Dynamic-> ?Dynamic -> String {
		return (new haxe.Template(fs.readFileSync(file, {encoding:"utf8"}))).execute;
	}
	public static function clearMttTemplate(contentFile:String, ?title:String):Dynamic->String {
		if (title == null) title = config.siteName;
		var contentTemplate = compileMttTemplate(contentFile);
		return function(opts) {
			var contentStr = contentTemplate(opts);
			return clearLayoutMttTemplate({title: title, content: contentStr});
		}
	}
	public static function compileEcoTemplate(file:String):Dynamic->String {
		return eco.compile(fs.readFileSync(file, {encoding:"utf8"}));
	}
	public static function clearEcoTemplate(contentFile:String, ?title:String):Dynamic->String {
		if (title == null) title = config.siteName;
		var contentTemplate = compileEcoTemplate(contentFile);
		return function(opts) {
			var contentStr = contentTemplate(opts);
			return clearLayoutEcoTemplate({title: title, content: contentStr});
		}
	}
	public static function docpadEjsTemplate(contentFile:String, ?title:String):Dynamic->String {
		if (title == null) title = config.siteName;
		var contentTemplate = compileEjsTemplate(contentFile);
		return function(opts) {
			var contentStr = contentTemplate(opts);
			return docpadTemplate({title: title, content: contentStr});
		}
	}
}
class Boot {
	public static function __init__() {
		untyped __js__("require('source-map-support').install()");
		untyped __js__("module.exports = hxapp");
	}
}