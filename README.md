# doc_manager-main 2

doc_manager  App provides services to Edit customers Details.

## Description

A customer who intends to use this app should first login into the app using his MSISDN. Having logged in successfully, a customer should be able to avail below mentioned services from the app -

- Register to doc_manager services
- View his details
- Manage his profile details using View/Edit functionalities


## Pre-Installation

Make sure you are using Flutter dev channel for development. This will ensure that we are using the latest Flutter null safety features that is required for our development.

Check Flutter channel thats's currently being used using the below command -
```bash
flutter channel
```

If you are using any other channel apart from dev, switch your channel to dev using the below command -
```bash
flutter channel stable
```

Upgrade Flutter to download the latest source code from dev channel -
```bash
flutter upgrade
```

## Installation

Download the project using git.

Resolve package dependencies of various modules -

```bash

 cd doc_manager-main 2
 flutter packages get
```

### Build Runner

Run [build_runner](https://dart.dev/tools/build_runner) code so that all the code and files are generated for serving both source and generated files. To start with, clean any pre-existing files using below command -

```bash
flutter packages pub run build_runner clean  
```
The build_runner package includes the following commands:
- build -> Performs a one-time build.
- test -> Runs tests.
- watch -> Launches a build server that watches for edits to input files. Responds to changes by performing incremental rebuilds.






### Config

Make sure that config folder with related files are available in below mentioned path so that ConfigReader is able to resolve config related dependencies -

```bash
doc_manager-main 2/lib/config
```

## Project Architecture

The project consists of a major library_package module and multiple country app modules. Any common code that country app module intends to use should be placed inside library_package.

library_package inturn is structured using clean architecture. It has 2 main directories -
- **core** - Contains files that forms core part of the project and is common between multiple screens

Each features directory is further broken down into 3 sub directories -
* **presentation** - Presentation layer doesn't do much by itself,uses UI .
* **domain** - Domain layer contains only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.
* **data** - The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data. Repository is where you decide if you return fresh or cached data, when to cache it and so on. You may notice that data sources don't return Entities but rather Models. The reason behind this is that transforming raw data (e.g JSON) into Dart objects requires some JSON conversion code. We don't want this JSON-specific code inside the domain Entities - what if we decide to switch to XML?



>If incase, you get --no-sound-null-safety error from any one of the packages that is being used in the project, you can disable null safety and run the project with unsound null safety using below command. However, this is not recommended.
```bash
flutter run --no-sound-null-safety
```

## Release

Current Flutter App is designed to be released in Android,

