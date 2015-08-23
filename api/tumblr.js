var Tumblr = require('tumblr')

var oauth = {
  consumer_key: 'Jm4LLTTfYDUdgasgPBlDJrnkLrE1qZ1dacSoJHMctfmsRKnOKr',
  consumer_secret: 'QkDhKxbqKT2Fi4nFZGFscTJFhQG6Q7AKJNLFyBAINSMk1KG5cR',
  token: 'fuDeZPiI0yG1dco2V9C2ifvixVQxHI4366LFZB8LV2GPilhfmx',
  token_secret: 'Sw1YT6cIgaAaLpW8oXKxJTr1t20Xt4601pZ7ABePjVKDhZT285'
};

var tumblr = new Tumblr.Tagged(oauth)

function search (query, next) {
  tumblr.search(query, { limit: 10 }, function (error, results) {
    if (error) next(error, null)
    var photosObject = { photosArray: [] }
    for (index in results) {
      var title = 'Blog (' + results[index].blog_name + ')'
      var photos = results[index].photos
      var source = "tumblr"
      for (photo in photos) {
        var url = photos[photo].original_size.url
        var photo = { title: title, source: source, url: url}
        photosObject.photosArray.push(photo)
      }
    }
    next(null, photosObject)
  })
}

exports.search = search
