<h1 align="center">
  <a href="https://github.com/caff-f2c/bid-generator">
    <img src="/doc/images/logo.svg" alt="Logo" width="125" height="125">
    <br>
    Bid Generator
  </a>
</h1>

<p align="center">
  <img src="https://github.com/caff-f2c/bid-generator/actions/workflows/ruby.yml/badge.svg?branch=main" alt="Build status">
</p>


Table of contents
-----------------

* [Introduction](#introduction)
* [Development](#development)
* [Deployment](#deployment)


Introduction
------------

Welcome to the CAFF Farm to Cafeteria Bid Generator. This repository contains an application written in Ruby on Rails.


Development
------------

### MacOS Dependencies

You will need the following packages on your system:

* Postgres
* Ruby 3.0
* Node 14
* Libvips

You can install all of these dependencies with [Homebrew](https://brew.sh):

```bash
$ brew install postgres ruby node yarn vips
```

### Setting up Rails

In order to start the application locally, you will need to copy the `.env.example` file to `.env` and configure your database:

```bash
$ cp .env.example .env
$ bin/rails db:setup
```


You can then start the Bid Generator application:

```bash
$ bin/dev
```

Alternatively, you can start the Rails server directly:

```bash
$ bin/rails server
```

The Bid Generator application will then be visible at [http://localhost:3000].


Deployment
----------

The Bid Generator relies on the following external services:

* Postgres
* Redis
* Amazon S3
* Amazon CloudFormation
* Amazon Simple Queue Service
* Amazon Simple Email Service


### Amazon Web Services

You will need an AWS account.

The Bid Generator uses the CloudFormation service to automate deployment. To create a CloudFormation stack of your own, you can click this button:

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://example-us-east-1.s3.amazonaws.com/stack.yml)


### Heroku

The production instance of Bid Generator is currently deployed to [Heroku](https://heroku.com).

To create your own hosted instance, you can click this button:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/CAFF-F2C/bid-generator)

You will need to enter the following environment variables, accessible inside of the CloudFormation stack created above, under the Outputs tab:

* AWS_REGION
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* BUCKET_NAME
* CDN_HOST
* DEFAULT_QUEUE_URL
