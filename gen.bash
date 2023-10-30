#!/bin/bash
echo 'in gen.bash'
swipl -g 'consult(md).' -g 'main.' -g 'halt.'
