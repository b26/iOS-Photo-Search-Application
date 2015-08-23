var Flickr = require('flickrapi');

var flickrOptions = {
  api_key: "16bcc68e4b250a2bbdf4d4dd0180885e",
  secret: "9257298b21efb105"
}

function search (query, next) {
  Flickr.tokenOnly(flickrOptions, function (error, flickr) {
    if (error) next(error, null)
    flickr.photos.search({
      text: query,
      tag: query,
      page: 1,
      per_page: 10,
      sort: "relevance"
    }, function (error, results) {
      var photosObject = { photosArray: [] }
      var photos = results.photos.photo
      for (photo in photos) {
        var title = photos[photo].title
        var source = "flickr"
        var url = "https://farm" + photos[photo].farm + ".staticflickr.com/" +
                  photos[photo].server + "/"  + photos[photo].id + "_" +
                  photos[photo].secret + ".jpg"
        var photo = {
          title: title,
          url: url,
          source: source
        }
        photosObject.photosArray.push(photo)
      }
      next(null, photosObject)
    })
  })
}

exports.search = search
