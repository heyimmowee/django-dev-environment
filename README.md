Overview
========

Tandoori django dev environment with docker.

Requirements
------------

- Linux kernel >= 3.8
- Install docker: http://docs.docker.com/installation/

Recommendations
---------------

For more convenience, I recommend you to add aliases from docker_aliases's file.
I will use those aliases to explain the How to below.

Read some documentation about docker: http://docs.docker.com/installation/#user-guide

How to use
----------

- Optional: copy your private key as "id_rsa" in the directory. It will be automatically added into the image for your github operations.

- You first need to build an image from the dockerfile. Get into your cloned directory then:

> d.build -t tandoori .

- d.images command should show you two images: debian and tandoori. The second one is made over the first one.

- Now we can run a container that will use the image you built:

> d.runprompt tandoori


