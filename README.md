# stuk

> **stuk** _n_., Dutch (_plural_ **stukken**, _diminutive_ **stukje** _n_)
> 1. piece, item (of a whole)
> 1. play, skit
> 1. document (especially official)
> 1. (_colloquial_) hottie, babe, attractive person (_of any gender_)

Source: [wiktionary.org](https://en.wiktionary.org/wiki/stuk)
## Summary
`stuk` is an app enabling users to monitor & gain insightful information about their fermentation schedules. Fermentations of all kinds require careful adhesion to temperature ranges, and home-fermenters (beer, kombucha, tempeh - yogurt!) such as myself are lazy & bad at making sure our fermentations happen in those ranges. A simple, intuitive web application accessible to a desktop browser provides real time temperature metrics for each device they have registered.

stuk uses `bash` to mimic the generation of data on an IoT device (e.g., a RaspberryPi with tempature sensors hooked up on a breadboard); `Node.js`, `AWS Lambda` & `AWS DynamoDB` act as a serverless RESTful API. A single-page web application in `Vue.js` & `SASS` displays metrics.

## Past
`stuk` was started during a two-week sprint as a final capstone while an Apprentice Software Developer at the [Nashville Software School](https://www.nashvillesoftwareschool.com) from Nov '17 to May '18. Aside from `Node.js`, I had little to no interaction with the tools implemented here. I chose these because they were the right tools, but also because I wanted to better understand serverless cloud computing, microservice architecture, and component-based applications.

## Future
1. Data comes from actual temperature sensors
    - Connect digital thermometers to a breadboard and then to a RaspberryPi, which processes the signal and makes API calls
    - Build temperature sensors with microcontrollers & wifi transmitters that connect to a person's home wireless router

1. Infrastructure as Code
    - Template cloud resources (e.g., Terraform, CloudFormation) provisioning
    
1. SPA deployment
    - How can Lambdas or `Lightsail` be leveraged to serve the SPA?
  
1. Continuous Deployment
    - How can resources be continuously deployed to AWS with merges into `master`?
  
1. Modularity
    - How far can modularity in a microservice architecture be pushed?
    - `Vue.js` application does not break out each UI component into totally discrete, independent resources
