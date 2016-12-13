'use strict';

const controller = require('lib/wiring/controller');
const models = require('app/models');
const Example = models.example;

const authenticate = require('./concerns/authenticate');

// index is a functino that takes 3 parameters.
// req = request, res = response, next =  a function that
// sends the request/response on to the next function in the chain if it is
// passed an object, it goes to the error handler.
// request & response are objects that represent HTTP requests & responses.
const index = (req, res, next) => {
// Access the database, find all examples.
  Example.find()
//  Take response from the database, render as JSON.
    .then(examples => res.json({ examples }))
// If there is an error, it is caught and sent to the error handling middleware.
    .catch(err => next(err));
};

// Takes request, response objects, and a next function
const show = (req, res, next) => {
// Takes the ID from the request object
// finds the object in the database
  Example.findById(req.params.id)
// gets the example by id.
// If there is a response, it sends that example as json. If not, it moves onto the
// next step.
    .then(example => example ? res.json({ example }) : next())
    .catch(err => next(err));
};

const create = (req, res, next) => {
// adds a key, _owner to req.body.example, and sets that to req.currentUser.id
  let example = Object.assign(req.body.example, {
    _owner: req.currentUser._id,
  });
// executes the create method on the example model with the example object
// that we just created with the data from the client and the current user as
// _owner
  Example.create(example)
// the newly created example we get from the database is rendered as JSON
    .then(newExample => res.json({ example: newExample }))
// if theres an error, send to the error handler.
    .catch(err => next(err));
};

const update = (req, res, next) => {
// creates an object with the id of the example passsed to us by the user
// and the currentUser's id as _owner
  let search = { _id: req.params.id, _owner: req.currentUser._id };
// Finding an example form the database with the id passed to us in the request,
// and the current user as owner. Will only find an object if the current user
// is the owner of the object.
// Will return null if the current user is not the owner of the example.
  Example.findOne(search)
// if successful
    .then(example => {
// checks if theres an example
      if (!example) {
// if theres not an example, call next.
        return next();
      }
// protects against malicious users by deleteing the _owner key from req.body
      delete req.body._owner;  // disallow owner reassignment. Delete is a key
      //word in JS and removes the key and the value.
      // returns a promise with the updated example
      return example.update(req.body.example);
    })
    // if the update is successful, we send a 200 status to the client
    .then(() => res.sendStatus(200))
    // if find or update fails, we send it to the error handler
    .catch(err => next(err));
};

const destroy = (req, res, next) => {
// create an object with the example id, and the current user's id as _owner.
  let search = { _id: req.params.id, _owner: req.currentUser._id };
// use the example model, and call the findOne method to find an example that
// matches the search terms.
  Example.findOne(search)
    .then(example => {
// if the example is falsey
// if the search parameters didnt match any examples.
      if (!example) {
// call the next function!
        return next();
      }
// removes the example form the database (destroys it)
      return example.remove();
    })
// if removing the example object was successful, return 200 http response.
    .then(() => res.sendStatus(200))
// handles an errors
    .catch(err => next(err));
};

module.exports = controller({
  index,
  show,
  create,
  update,
  destroy,
// runs the authenticate middleware for all controller actions except index
// and show.
}, { before: [
  { method: authenticate, except: ['index', 'show'] },
], });
