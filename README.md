qnn.com.cn-v2
=============

Jekyll version of [qnn.com.cn-v1](https://github.com/qnn/qnn.com.cn-v1).

Please note that this repository is not being actively maintained.

![qnn com cn-v2](https://f.cloud.github.com/assets/1284703/2059891/2908c582-8be3-11e3-94c3-b25c2b96378c.jpg)

How to use
----------

The database in qnn.com.cn-v1 is in MySQL format. It has been converted to SQLite format and put in _parser/database.zip.

You can generate posts in knowledge, news, product and video sections by executing corresponding getter script, for example, ``ruby get_products.rb`` will generate all product posts in /products directory.

It takes about 20 seconds to build whole website. If you want to test and modify pages other than product details page, you can empty ``_layouts/product_article.html`` first, so you can see the changes quickly. If you want to test and modify those pages, you can just keep small amounts of products. Less posts or empty detail template page will build pages more quickly.

Deploy
------

You may need to use [net.cn-utils](https://github.com/caiguanhao/net.cn-utils) to upload the site content to QNN's M3 virtual hosting because it supports transfering files via FTP only.

    # clone repositories
    $ cd /srv
    $ git clone git://github.com/qnn/qnn.com.cn-v2.git
    $ git clone git://github.com/qnn/images-v2.git
    $ git clone git://github.com/caiguanhao/net.cn-utils.git

    # build website
    $ cd /srv/qnn.com.cn-v2
    $ jekyll build

    # log in
    $ cd ../net.cn-utils
    $ bash login.sh -u hmu123456 -p 1234567890

    # then upload images
    $ bash upload.sh -f ../images-v2 -d

    # upload static files
    $ bash upload.sh -f ../qnn.com.cn-v2/_site -d

Update
------

    $ cd /srv/qnn.com.cn-v2
    $ git pull origin master
    $ jekyll build

    $ cd ../net.cn-utils
    $ bash login.sh -u hmu123456 -p 1234567890

    $ bash upload.sh -f ../qnn.com.cn-v2/_site -d

Requirements
------------

* Jekyll 1.0+

Copyright
---------

Web design by caiguanhao.  
Copyright (C) 2013 caiguanhao.  
Powered by Jekyll, the blog-aware, static site generator in Ruby.

Developer
---------

* caiguanhao
