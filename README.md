qnn.com.cn-v2
=============

Jekyll version of [qnn.com.cn-v1](https://github.com/qnn/qnn.com.cn-v1).

How to use
----------

The database in qnn.com.cn-v1 is in MySQL format. It has been converted to SQLite format and put in _parser/database.zip.

You can generate posts in knowledge, news, product and video sections by executing corresponding getter script, for example, ``ruby get_products.rb`` will generate all product posts in /products directory.

It takes about 20 seconds to build whole website. If you want to test and modify pages other than product details page, you can empty ``_layouts/product_article.html`` first, so you can see the changes quickly. If you want to test and modify those pages, you can just keep small amounts of products. Less posts or empty detail template page will build pages more quickly.

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