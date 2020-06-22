# Class Directory Made in Sinatra

This is a contact management application that follows the MVC design pattern lets users manage their course and classmate contact information through create, read, update, and delete functions.

[Watch this video demo on how to use the app](https://youtu.be/Sr9aR4pyU4k)

[Blog Post about learning Sinatra](https://medium.com/@lushiyun/practical-lessons-learned-from-developing-a-sinatra-project-classmate-directory-27fba0eea8aa)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Clone and run the following command inside this project's directory to load dependencies

    $ bundle

### Development

Run the following command to load database schema

    $ bundle exec rake db:schema:load

Start up local server

    $ bundle exec shotgun

For interactive console

    $ bundle exec rake console

## Built With

* [Ruby 2.6.1](https://www.ruby-lang.org/en/news/2019/01/30/ruby-2-6-1-released/)
* [Sinatra](http://sinatrarb.com/) - The web framework used
* [Bundler](https://bundler.io/) - Dependency Management

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/lushiyun/c8af9e2f2d6470468cfc37aa28f6edeb) for details on the code of conduct and the process for contributing.

## Versioning

Thie repository uses [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/lushiyun/sinatra-classmate-directory-app/tags). 

## Author

* **Shiyun Lu** - *Initial work* - [lushiyun](https://github.com/lushiyun)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details