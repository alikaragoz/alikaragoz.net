#alikaragoz.net

A very simple photo written in Rails. Before that I was using a custom Wordpress theme until I decide to write my own blogging engine using Markdown syntax.

![](https://raw.github.com/alikaragoz/alikaragoz.net/master/doc/alikaragoz.net-screenshot.png)

##Installation

**Note:** I am using Ruby 1.9.3 and Rails 3.2.8. If you are not familiar with Rails please try to document yourself a little bit before digging into this.

The database system used is Postgres. If you don't have it already, you'll need to install Postgres. You can do this easily with [Postgres.app](http://postgresapp.com/)

Run the following queries to setup the user in Postgres:

    $ psql postgres -h localhost
    # CREATE USER alikaragoz SUPERUSER;\q

Now all you need to do is bundle and initiate the database :

    $ bundle install
    $ rake db:create
    $ rake db:migrate

then start the server with [Thin](http://code.macournoyer.com/thin/):

    $ bundle exec thin start

Then open <http://localhost:3000> in your browser to see it running. If you have issues getting it up and running, [send me an email](mailto:mail@alikaragoz.net).

In production environment you need to run:

	$ bundle exec thin start -e production

I advise you to test your app locally in production mode before publishing it online (of course this is obvious).


**Note:** The application will crash when accessing the "Browse" section because it points to the "All" tag (http://localhost:3000/tags/all).
To avoid that you have to create a post and associate it to the tag named "All".

## Admin

You have to define environment variables in order to access the administration: `ADMIN_USERNAME` and `ADMIN_PASSWORD`.

## Publishing

### Edition
- To access the admin and create new posts, go to <http://localhost:3000/login>.
- To edit a post just append the word `edit` at the of a post url <http://localhost:3000/posts/hello/edit>

### Pictures
- To link a picture inside a post : `![](/photos/picture.jpg)`
- The images should be placed into : `/public/photos/picture.jpg`
- The images should be placed into : `/public/thumbnails/picture_thumbnail.jpg` (Note the extension of the thumbnails `_thumbnail.jpg`)
- To pick a specific image for the thumbnails just do that `![x](/photos/picture.jpg)`

Take a look at this script : [`post.command`](https://github.com/alikaragoz/alikaragoz.net/blob/master/doc/post.command). It resizes, uploads and generates a post automatically for you.  
You only need to put images in the same folder as `post.command` and double click on it.   
**Note:** Before using this script, open it and edit the variables inside accordingly to your preferences.


##Todo
- Better management of images
- Better management of tags

## Contact

Ali Karagoz

- http://github.com/alikaragoz
- http://twitter.com/alikaragoz
- http://alikaragoz.net