const jsonServer = require('json-server');
const server = jsonServer.create();
const middlewares = jsonServer.defaults();
const port = process.env.PORT || 3000;

var ua = require('universal-analytics');

var visitor = ua('UA-116049284-3');

server.use(middlewares);

// https://github.com/request/request
var request = require('request')
var opts = { url: 'https://raw.githubusercontent.com/kkkkkt/animal_data/master/db.json', json: true }

request(opts, function (error, response, body) {
  if (error) throw error
  const router = jsonServer.router(body);
  visitor.pageview("/").send(); 

  server.use(router)
  server.listen(port)
})
