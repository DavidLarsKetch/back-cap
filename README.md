# stuk

> **stuk** _n_., Dutch (_plural_ **stukken**, _diminutive_ **stukje** _n_)
> 1. piece, item (of a whole)
> 1. play, skit
> 1. document (especially official)
> 1. (_colloquial_) hottie, babe, attractive person (_of any gender_)

Source: [wiktionary.org](https://en.wiktionary.org/wiki/stuk)
## Summary
_stuk is currently in development._

stuk is a data-driven IoT application enabling the user to monitor & gain insightful temperature information about their fermentation schedules. Fermentations of all kinds require careful adhesion to temperature ranges, and home-fermenters (beer, kombucha, tempeh - yogurt!) such as myself are lazy & bad at making sure our fermentations happen in those temperature ranges. With stuk, a user can quickly set up their IoT device (I used what I had laying around - a [RaspberryPi](https://www.raspberrypi.org)) to use stuk. A long-term goal is to craft wifi enabled temperature sensors so that users can in minutes increase the number of fermentations they are tracking. A simple, intuitive web application accessible to a desktop browser provides real time temperature metrics for each device they have registered.

stuk uses `bash` for the IoT device; `Node.js`, `AWS Lambda` & `AWS DynamoDB` for the serverless backend & database; and `Vue.js` & `SASS` for the single-page web application. A goal is to build stuk according to a microservice architecture, though the current implementation still follows a monolithic approach, by and large. This would be a meaningful restructuring because of the possibility of expanding the kinds of monitoring done by stuk into additional areas. For example, a developer ought to follow the design pattern for temperature monitoring in order to support monitoring soil moisture in house plants. As long as the IoT device has been built to interface with the stuk API, it can quickly be added to the application.


## Current
stuk is at a proof-of-concept phase for supporting temperature monitoring. Bash scripts are available for generating fake temperature readings and these work on a `Raspberry Pi`.  An `AWS API Gateway` -> `AWS Lambda` -> `AWS DynamoDB` pipeline for basic CRUD responsibilities has been laid. The results of that are presented in a simple `Vue.js` web app.

This portion of the application was completed during a two-week sprint as a final capstone while an Apprentice Software Developer at the [Nashville Software School](https://www.nashvillesoftwareschool.com) from Nov '17 to May '18. Aside from `Node.js`, I had little to no interaction with the tools implemented here. I chose these because they were the right tools, but also because I wanted to better understand serverless cloud computing, microservice architecture, and component-based applications.

## Future
The hardware components are in development, and as a complete greenhorn in hardware, will take some troubleshooting. Right now, stuk relies on using a `Raspberry Pi`, but this is not a desirable solution. A long-term goal is to build temperature sensors with microcontrollers & wifi transmitters that connect to a person's home wireless router.

stuk does not quite conform to a 'true' microservice architecture, quite yet, as the serverless `AWS Lambda` functions still field all API resource paths & verbs; furthermore, the `Vue.js` application does not break out each UI component into totally discrete, independent resources. For example, the `AWS Lambda` `Node.js` script handling the `Data` `AWS DynamoDB` database relies on the script for the `Stat` `AWS DynamoDB` database. In a true microservice fashion, these should be not be dependencies _if_ intended as independent components.

What does it look like for someone to implement stuk in their own home? Are they installing an application to their desktop? Smartphone? Are they cloning this repo, compiling, and running the code? Uploading a container to their own AWS? Are they simply registering themselves & their devices on a web application?
