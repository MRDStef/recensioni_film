#!/bin/bash

composer install --no-interaction --prefer-dist || composer install --no-interaction --prefer-source
/usr/sbin/apache2ctl -DFOREGROUND
