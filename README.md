# newsboy

Feed notification app.

# Quickstart

```sh
$ git clone git@github.com:mizoR/newsboy.git
$ cd newsboy
$ heroku create newsboy
$ heroku config:add IM_KAYAC_USERNAME='<your-im-kayac-com-username>'
$ heroku config:add IM_KAYAC_SECRET='<your-im-kayac-com-secret>'
$ heroku config:add TZ='Asia/Tokyo'
$ heroku config:add AT='06:** 07:** 08:** 09:** 10:** 11:** 12:** 13:** 14:** 15:** 16:** 17:** 18:** 19:** 20:**'
$ heroku config:add RSS_URL_<KEY1>=http://example1.com/rss
$ heroku config:add RSS_URL_<KEY2>=http://example2.com/rss
$ heroku config:add RSS_URL_<KEY3>=http://example3.com/rss
$ git push heroku master
```

