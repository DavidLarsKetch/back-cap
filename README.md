# stuk

> **stuk** _n_. (_plural_ **stukken**, _diminutive_ **stukje** _n_)
1. piece, item (of a whole)
1. play, skit,
1. document (especially official)
1. (_colloquial_) hottie, babe, attractive person (_of any gender_)

Source: [wiktionary.org](https://en.wiktionary.org/wiki/stuk)
## Summary
_Stuk is currently in development._

Stuk is a data-driven IoT application enabling the user to monitor & gain insightful temperature information about their fermentation schedules. Fermentations of all kinds require careful adhesion to temperature ranges, and home-fermenters (beer, kombucha, tempeh - yogurt!) such as myself are lazy & bad at making sure our fermentations happen in those temperature ranges. With Stuk, a user can quickly set up their IoT device (I used what I had laying around - a [RaspberryPi](https://www.raspberrypi.org)) to use Stuk. A simple, intuitive web application accessible for their smart phone or desktop browser provides real time temperature metrics.

Stuk uses `bash` & `Python` for the IoT device; `Node.js`, `AWS Lambda` & `AWS DynamoDB` for the serverless backend & database; and `Vue.js` & `SASS` for the single-page web application.
