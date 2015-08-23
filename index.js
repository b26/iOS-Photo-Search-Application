var Hapi = require('hapi')
var Good = require('Good')
var api = require('./api/search.js')

var server = new Hapi.Server()

function search (query, next) {
  api.search(query, function (error, results) {
    if (error) next(error, null)
    next(null, results)
  })
}

server.connection({
  host: 'localhost',
  port: '8000'
})

server.method('search', search, {
  cache: {
    expiresIn: 10000
  }
})

server.route({
  method: 'GET',
  path: '/',
  handler: function (request, reply) {
    reply('Hello There :D!')
  }
})

server.route({
  method: 'GET',
  path: '/{name}',
  handler: function (request, reply) {
    reply('Hello, ' + request.params.name)
  }
})

server.route({
  method: 'GET',
  path: '/api/{query}',
  handler: function (request, reply) {
    server.methods.search(request.params.query, function (error, results) {
      reply(results)
    })
  }
})

server.register({
    register: Good,
    options: {
        reporters: [{
            reporter: require('good-console'),
            events: {
                response: '*',
                log: '*'
            }
        }]
    }
}, function (err) {
    if (err) {
        throw err; // something bad happened loading the plugin
    }

    server.start(function () {
        server.log('info', 'Server running at: ' + server.info.uri);
    });
});
