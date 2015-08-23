var parallel = require('async').parallel
var flatten = require('underscore').flatten
var shuffle = require('underscore').shuffle
var flickr = require('./flickr')
var tumblr = require('./tumblr')

var stack = {}

function search (query, cb) {
  stack.flickr = function (next) {
    flickr.search(query, function (error, results) {
      var photosArray = []
      if (error) next(error, null)
      var photos = results.photosArray
      for (index in photos) {
        var photo = photos[index]
        photosArray.push(photo)
      }
      next(null, photosArray)
    })
  }

  stack.tumblr = function (next) {
    tumblr.search(query, function (error, results) {
      var photosArray = []
      if (error) next(error, null)
      var photos = results.photosArray
      for (index in photos) {
        var photo = photos[index]
        photosArray.push(photo)
      }
      next(null, photosArray)
    })
  }

parallel(stack, function (error, results) {
    if (error) cb(error, null)
    var photosArray = []
    for (key in results) {
      photosArray.push(results[key])
    }
    photosArray = shuffle(flatten(photosArray))
    cb(null, photosArray)
  })
}

exports.search = search
