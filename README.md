# Cabify Test app

For networking I use [AbsNet](https://github.com/santiagofranco/AbsNet), a lib of mine, that I use in personal projects.
It is not "production-ready" yet, that's why I copied it as a folder in this project instead of using cocoapods.

All the unit test of both of the modules of the app are made with TDD, by using XCTestCase class. And without using libs to mocking due to the simplicity of the app. 

master branch contains a VIPER version, and it is a version that I consider ready for production.

UI testing left out because of simplifying.

The VIPER architecture is an implementation of this [clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
