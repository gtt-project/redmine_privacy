# Redmine Privacy Plugin

This plugin lets you add several privacy related options to Redmine projects

## Requirements

- Redmine >= 4.0.0

## Installation

To install Redmine Privacy plugin, download or clone this repository in your Redmine installation plugins directory!

```
cd path/to/plugin/directory
git clone https://github.com/gtt-project/redmine_privacy.git
```

Then run

```
bundle install
bundle exec rake redmine:plugins:migrate
```

After restarting Redmine, you should be able to see the Redmine Privacy plugin in the Plugins page.

More information on installing (and uninstalling) Redmine plugins can be found here: http://www.redmine.org/wiki/redmine/Plugins

## How to use

TBD

## Contributing and Support

The GTT Project appreciates any [contributions](https://github.com/gtt-project/.github/blob/main/CONTRIBUTING.md)! Feel free to contact us for [reporting problems and support](https://github.com/gtt-project/.github/blob/main/CONTRIBUTING.md).

## Version History

- 2.0.0 Support Redmine 5.0 and drop Redmine <= 3.4 support
- 1.3.2 Publish on GitHub

See [all releases](https://github.com/gtt-project/redmine_privacy/releases) with release notes.

## Authors

- [Jens Kraemer](https://github.com/jkraemer)
- [Daniel Kastl](https://github.com/dkastl)
- [Thibault Mutabazi](https://github.com/eyewritecode)
- [Ko Nagase](https://github.com/sanak)
- ... [and others](https://github.com/gtt-project/redmine_privacy/graphs/contributors)

## LICENSE

This program is free software. See [LICENSE](LICENSE) for more information.
