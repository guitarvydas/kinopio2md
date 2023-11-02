#!/usr/bin/env node
//'use strict'

const fs = require ('fs');

var input = fs.readFileSync ('/dev/fd/0', 'UTF-8');
var output = decodeURIComponent (input.replace (/%27/g, "'").replace (/%22/g, '"'));
console.log (output);
