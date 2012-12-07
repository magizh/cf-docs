---
title: Node.js
description: Node.js Application Development with Cloud Foundry
tags:
    - nodejs
    - express
    - tutorial
---

This is a guide for Node.js developers deploying on Cloud Foundry. It shows you how to set up and successfully deploy Node.js applications to Cloud Foundry.

Node.js is an event-driven, scalable, JavaScript-based platform for networking applications. Cloud Foundry provides a runtime environment for Node.js applications and the Cloud Foundry deployment tools automatically recognize Node.js applications.

Before you get started, you need the following:

+	A [Cloud Foundry account](http://cloudfoundry.com/signup)

+	The [vmc](/docs/tools/vmc/installing-vmc.html) Cloud Foundry command line tool

+	A [Node.js](http://nodejs.org/) installation matching the version of Node.js on your Cloud Foundry instance. See [Checking the NodeJS version on your Cloud Foundry instance](#checking-the-nodejs-version-on-your-cloud-foundry-instance) below.

## Deploying Node.js Applications to Cloud Foundry

When you deploy a Node.js application to Cloud Foundry, the current directory must contain the application and the app.js file.

Here are steps to create and deploy a "hello world" Node.js web server application that uses the [Express](http://expressjs.com) web module:

### Create the App

Create a directory for the application and change into it.

``` bash
$ mkdir hello-node
$ cd hello-node
```

Use `npm` (Node Package Manager) to install the Express module:

```bash
$ npm install express
```

Create the file `app.js` with the following code:
```javascript

var app = require('express').createServer();
app.get('/docs/', function(req, res) {
    res.send('Hello from Cloud Foundry');
});
app.listen(3000);

```

If your application is using a server file other than server.js, app.js, index.js, main.js and application.js, then a package.json file is required.
If you have two of the files listed above inside the root of your package, then you would need package.json to specify which file with which to start.

By default, here is the order of files loaded as your server starts:

1. application.js

2. main.js

3. index.js

4. app.js

5. server.js

For example, if main.js and app.js are in your root package, main.js will be read by default, unless you specify otherwise in the package.json.

Create a `package.json` file with the following content:

```javascript
{
 "name":"hello-node",
  "version":"0.0.1",
  "scripts":{
      "start":"node server.js"
  }
}

```

If there is a `server.js` file in the root of your package, npm will use the default the `start` command of `node server.js`.
If your application is using app.js as its starting point, you don't need package.json.


### Deploy the App

Target Cloud Foundry and log in with your Cloud Foundry credentials:

```bash
$ vmc target api.cloudfoundry.com
$ vmc login
```

Push the application. You can press `Enter` to accept the defaults at most of the prompts, but be sure to enter a unique URL for the application. Here is an example push:

``` bash
$ vmc push
	Would you like to deploy from the current directory? [Yn]:
	Application Name: hello-node
	Application Deployed URL [hello-node.cloudfoundry.com]:
	Detected a Node.js Application, is this correct? [Yn]:
	Memory Reservation (64M, 128M, 256M, 512M, 1G) [64M]:
	Creating Application: OK
	Would you like to bind any services to 'hello-node'? [yN]:
	Uploading Application:
	  Checking for available resources: OK
	  Packing application: OK
	  Uploading (0K): OK
	Push Status: OK
	Staging Application: OK
	Starting Application: ................ OK
```

Access the application with your browser at the specified URL, [http://hello-node.cloudfoundry.com](http://hello-node.cloudfoundry.com) in this example.

## Changing the version of Node your App uses

You can use the runtime flag and pass the desired runtime. For how to list the runtimes see the next section

Example to use Node 0.6.8

```bash
vmc push --runtime=node06
```

## Checking the Node.js version on your Cloud Foundry instance

To have the best development experience, we recommend that you work on your local machine with the same version of Node.js as your target Cloud Foundry instance.

To find out what version of Node.js is on your Cloud Foundry instance run this command:

``` bash
$ vmc runtimes

+--------+-------------+-----------+
| Name   | Description | Version   |
+--------+-------------+-----------+
| java   | Java 6      | 1.6       |
| ruby18 | Ruby 1.8    | 1.8.7     |
| ruby19 | Ruby 1.9    | 1.9.2p180 |
| node   | Node.js     | 0.4.12    |
| node06 | Node.js     | 0.6.8     |
| node08 | Node.js     | 0.8.2     |
+--------+-------------+-----------+

```

+ Then download the specific version of Node.js from [here](https://github.com/joyent/node/tags).
+ Unzip it.
+ Install it by following the instructions in the README file.

## Next Steps

+	[Using Cloud Foundry MongoDB services](/docs/services/mongodb/nodejs-mongodb.html) from Node.js applications
+	[Using Cloud Foundry RabbitMQ services](/docs/services/rabbitmq/nodejs-rabbitmq.html) from Node.js

## Read More

+ [Cloud Foundry Supports Node.js Modules with NPM](http://blog.cloudfoundry.com/2012/05/24/cloud-foundry-supports-node-js-modules-with-npm/)
+ [New Runtime Module for Node.js Applications](http://blog.cloudfoundry.com/2012/08/21/new-runtime-module-for-node-js-applications/)
+ [Cloud Foundry Now Supports Auto-Reconfiguration for Node.js Applications](http://blog.cloudfoundry.com/2012/08/14/cloud-foundry-now-supports-auto-reconfiguration-for-node-js-applications/)
