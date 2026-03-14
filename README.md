
![Swift Ride](/Resources/swift-ride-hero-image.png)

# SwiftRide

SwiftRide is a learning project where we build a ride sharing application from scratch while documenting the entire journey.

The goal of this project is not to compete with Uber or Lyft. The goal is to understand how real systems are built. Instead of relying heavily on AI to generate code, this project focuses on writing the code ourselves and understanding the architecture behind it.

SwiftRide will gradually evolve into a complete system with a backend API, a relational database, and a SwiftUI client application.

---

# Project Goals

The main purpose of SwiftRide is to demonstrate how different pieces of a modern application fit together.

During this project we will explore:

* Designing a backend API
* Modeling relational data using PostgreSQL
* Using Sequelize ORM for database migrations and models
* Implementing authentication
* Building a SwiftUI client application
* Connecting the client to the backend

Each step of the process will be documented in a series of articles so developers can follow along.

---

# Architecture

SwiftRide is divided into two main components.

```
SwiftRide
 ├── SwiftRideServer
 └── SwiftRideClient
```

### SwiftRideServer

The backend service built using Node.js and Express.

Responsibilities include:

* REST API
* authentication
* database access
* business logic

Technology stack:

* Node.js
* Express
* PostgreSQL
* Sequelize ORM

---

### SwiftRideClient

The frontend mobile application built using SwiftUI.

Responsibilities include:

* user interface
* network communication with backend
* displaying ride information
* user authentication

Technology stack:

* Swift
* SwiftUI
* URLSession networking

---

# Tech Stack

Backend

* Node.js
* Express
* Sequelize ORM
* PostgreSQL

Frontend

* Swift
* SwiftUI

Development Tools

* BeeKeeper Studio (database inspection)
* Postgres App
* Xcode

---

# Getting Started

## 1. Install PostgreSQL

The easiest way to install PostgreSQL on macOS is using:

[https://postgresapp.com](https://postgresapp.com)

After installing the application, create the database:

```
CREATE DATABASE swiftridedb;
```

---

## 2. Setup Backend

Navigate to the backend folder.

```
cd SwiftRideServer
```

Initialize the project.

```
npm init
```

Install dependencies.

```
npm install express cors sequelize pg
```

Install Sequelize CLI.

```
npm install --save-dev sequelize-cli
```

Initialize Sequelize.

```
npx sequelize-cli init
```

This will create:

```
config/
models/
migrations/
seeders/
```

---

## 3. Run Database Migrations

Once migrations are created you can run them using:

```
npx sequelize-cli db:migrate
```

This will create the tables defined in your migrations.

---

## 4. Setup SwiftUI Client

Open Xcode and create a new SwiftUI project.

```
SwiftRideClient
```

Keep the client and server projects inside the same parent folder.

```
SwiftRide
 ├── SwiftRideServer
 └── SwiftRideClient
```

---

# Learning Series

SwiftRide is accompanied by a step by step tutorial series.

Part 1
Setting Up the Stack
[https://azamsharp.com/2026/03/11/swiftride-setting-up-the-stack.html](https://azamsharp.com/2026/03/11/swiftride-setting-up-the-stack.html)

Part 2
Creating the Models
[https://azamsharp.com/2026/03/12/swiftride-creating-the-models.html](https://azamsharp.com/2026/03/12/swiftride-creating-the-models.html)

More parts will be added as the project evolves.

---

# Why This Project Exists

The software industry is moving quickly toward AI generated code. These tools are useful, but they can also encourage developers to skip the most important part of learning: understanding how systems actually work.

SwiftRide is intentionally built step by step so developers can see how everything fits together.

The goal is simple.

Write the code.
Understand the architecture.
Enjoy building software again.

---

# Author

Mohammad Azam
[https://azamsharp.com](https://azamsharp.com)

iOS Developer
Educator
Creator of AzamSharp School
