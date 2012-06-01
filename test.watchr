#! /usr/bin/env watchr

watch(/.*(src|test)\/.*\.coffee/) do |md|
   system './node_modules/.bin/icake test'
end