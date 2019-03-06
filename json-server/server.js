const jsonServer = require('json-server');
const server = jsonServer.create();
//const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();
const port = process.env.PORT || 3000;

server.use(middlewares);

var request = require('request')
var opts = { url: 'https://raw.githubusercontent.com/kkkkkt/animal_data/master/db.json', json: true }

request(opts, function (error, response, body) {
  if (error) throw error
  const router = jsonServer.router(body)

  server.use(router)
  server.listen(port)
})
