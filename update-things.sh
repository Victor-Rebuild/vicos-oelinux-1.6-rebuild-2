#!/bin/bash

#cd anki/victor
#git pull origin main
#cd EXTERNALS
#git pull origin main
cd anki/vic-cloudless
git pull origin vic-cloud-and-cloudless
cd ../wired
git pull origin main
cd ../../poky/bitbake
git pull origin master
cd ../meta-openembedded
git pull origin master
cd ../openembedded-core
git pull origin master
