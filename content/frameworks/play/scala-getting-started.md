---
title: Play Java
description: Play Scala Application Development with Cloud Foundry
tags:
    - play
    - scala
    - tutorial
---

This is a guide for Scala developers using the Play framework to build their apps and
deploy on Cloud Foundry. It shows you how to set up and successfully deploy Play Scala applications
to Cloud Foundry.

Play is based on a lightweight, stateless, web-friendly architecture and features predictable
and minimal resource consumption (CPU, memory, threads) for highly-scalable applications.
Cloud Foundry provides a runtime environment for Play 2.0 applications and the Cloud Foundry
deployment tools automatically recognize Play applications.

Before you get started, you need the following:

+  A [Cloud Foundry account](http://cloudfoundry.com/signup)

+  The [vmc](/docs/tools/vmc/installing-vmc.html) Cloud Foundry command line tool

+  A [Play 2.0 ](http://www.playframework.org/documentation/2.0.2/Home) installation

## Deploying Play Scala Applications to Cloud Foundry

When you deploy a Play application to Cloud Foundry, the current directory must contain
the application, the conf folder and app folders which are used by Cloud Foundry to detect
a Play application.

Here are steps to create and deploy a "hello world" Play application in Scala.

### Install Play

Please follow the instructions given on the [Play website](http://www.playframework.org/documentation/2.0.2/Installing)
to download and install Play 2.0.

Make sure the play script is in your path. On a Linux or a Mac environment this can be done using

``` bash
export PATH=$PATH:/path/to/play20
```
On Windows you’ll need to set it in the global environment variables.

### Check the play command is available
Run the `play help` command in the shell.

``` bash
$play help
```
The Following screen should show up.

![play-help.png](/docs/images/screenshots/play/play-help.png)

### Create the App

To create the app, type the following command:

``` bash
$ play new helloworld-scala

```
Choose the Appropriate template (Scala in our case).

``` bash
$play new helloworld-scala
       _            _
 _ __ | | __ _ _  _| |
| '_ \| |/ _' | || |_|
|  __/|_|\____|\__ (_)
|_|            |__/

play! 2.0.2, http://www.playframework.org

The new application will be created in /Users/[username]/play/mysamples/helloworld-scala

What is the application name?
> helloworld-scala

Which template do you want to use for this new application?

  1 - Create a simple Scala application
  2 - Create a simple Java application
  3 - Create an empty project

> 1

OK, application helloworld-scala is created.

Have fun!
```

The following directory structure gets created:

```bash
$cd helloworld-scala
$ls
README
app
conf
project
public
```
This will create a new directory `helloworld-scala`.

### Run the Default App Locally

Try running the app locally with the following command inside the play console:

```bash
[helloworld-scala] $ run

[info] Updating {file:/Users/[username]/play/mysamples/helloworld-scala/}helloworld...
[info] Done updating.
--- (Running the application from SBT, auto-reloading is enabled) ---

[info] play - Listening for HTTP on port 9000...

(Server started, use Ctrl+D to stop and go back to the console...)
```
You should see the default Play template being served at `http://localhost:9000`.

![default-play-home.png](/docs/images/screenshots/play/default-play-home.png)

### Modify the Controller

In this step, we modify the controller `helloworld-scala/app/controllers/Application.scala`

```scala
package controllers

import play.api._
import play.api.mvc._

object Application extends Controller {

  def index = Action {
    Ok("Hello World in Scala")
  }

}

```
The default view in the browser would look like this:

![play-helloworld-scala.png](/docs/images/screenshots/play/play-helloworld-scala.png)


### Deploy the App

Target Cloud Foundry and log in with your Cloud Foundry credentials:

```bash
$ vmc target api.cloudfoundry.com
$ vmc login
```

Have Play clean the project and then create a distributable zip file:

```bash
$ play clean dist
```

The output should show that a zip file was create in ./dist/ with a file name not too disimilar to <projectname>-1.0-SNAPSHOT.zip,
the output should end with something like;

```bash
Your application is ready in /Users/danhigham/Projects/play/HelloWorld/dist/helloworld-1.0-SNAPSHOT.zip
```

Push the application. You can press `Enter` to accept the defaults at most of the prompts,
but be sure to enter a unique URL for the application and to also specify the location of the zip file 
using the path switch. Here is an example push:

``` bash
$ vmc push --path=./dist/helloworld-1.0-SNAPSHOT.zip
    Would you like to deploy from the current directory? [Yn]:
    Application Name: helloworld-scala
    Application Deployed URL [helloworld-scala.cloudfoundry.com]:
    Detected a Play Application, is this correct? [Yn]:
    Memory Reservation (64M, 128M, 256M, 512M, 1G) [64M]:
    Creating Application: OK
    Would you like to bind any services to 'helloworld-scala'? [yN]:
    Uploading Application:
      Checking for available resources: OK
      Packing application: OK
      Uploading (0K): OK
    Push Status: OK
    Staging Application: OK
    Starting Application: ................ OK
```

Access the application with your browser at the specified URL,
 [http://helloworld-scala.cloudfoundry.com](http://hello-scala.cloudfoundry.com) in this example.

![play-helloworld-scala-cf.png](/docs/images/screenshots/play/play-helloworld-scala-cf.png)



