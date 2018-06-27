# Redmine Privacy Plugin

This plugin lets you add several privacy related options to Redmine projects


## Requirements

 - Redmine >= 3.4.0

## Installation

To install Redmine privacy plugin, download or clone this repository in your Redmine installation plugins directory! 

`git clone https://hub.georepublic.net/gtt/redmine_privacy.git`

Then run

`bundle install`

followed by

`bundle exec rake redmine:plugins:migrate`


After restarting Redmine, you should be able to see the Redmine Resource Manager in the Plugins page.

More information on installing Redmine plugins can be found here: http://www.redmine.org/wiki/redmine/Plugins


## Version History

  - 1.3.1 Fixes tests, removes translation string
  - 1.3.0 Adds display name support
  - 1.2.0 Allows users to change display name
  - 1.1.0 Bugfix, adds Japanese translation
  - 1.0.1 Bugfix
  

## Authors

  - [Jens Kraemer](https://github.com/jkraemer)

  - [Daniel Kastl](https://github.com/dkastl)


## LICENSE

GPL v3.0
