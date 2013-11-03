appConfig = require('./config')
docpadConfig = {
  port: appConfig.port,
	templateData:
		site:
			url: "http://x40.ru",
			title: "X40",
			description: "«аказна€ разработка информационных систем и программного обеспечени€",
			keywords: "разработка мобильных приложений, разработка мобильных версий, заказна€ разработка, разработка на заказ, программное обеспечение, ѕќ, разработка информационных систем, разработка сайтов",
			author: "Roman Meleshin",
			email: "sd@x40.ru",
			styles: [
				"/styles/twitter-bootstrap.css"
				"/styles/style.css"
			]
			scripts: [
				"//cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"
				"//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
				"/vendor/twitter-bootstrap/dist/js/bootstrap.min.js"
				"/scripts/script.js"
			]
		getPreparedTitle: ->
			if @document.title
				"#{@document.title} | #{@site.title}"
			else
				@site.title
		getPreparedDescription: ->
			@document.description or @site.description
		getPreparedKeywords: ->
			@site.keywords.concat(@document.keywords or []).join(', ')
	collections:
		pages: (database) ->
			database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])
		posts: (database) ->
			database.findAllLive({tags:$has:'post'}, [date:-1])
#	plugins:
#		downloader:
#			downloads: [
#				{
#					name: 'Twitter Bootstrap'
#					path: 'src/files/vendor/twitter-bootstrap'
#					url: 'https://codeload.github.com/twbs/bootstrap/tar.gz/master'
#					tarExtractClean: true
#				}
#			]
}
module.exports = docpadConfig
