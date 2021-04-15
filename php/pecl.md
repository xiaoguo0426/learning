> The pecl command is used to install PECL extensions.

pecl [ options ] command [command-options] <parameters>

#### OPTIONS
- -v
> increase verbosity level (default 1)
- -q
> be quiet, decrease verbosity level
- -c file
> find user configuration in file
- -C file
> find system configuration in file
- -d foo=bar
> set user config variable foo to bar
- -D foo=bar
> set system config variable foo to bar
- -G
> start in graphical (Gtk) mode
- -S
> store system configuration
- -s
> store user configuration
- -y foo
> unset foo in the user configuration
- -V
> version information
- -h
> -? display help/usage


#### COMMANDS
- build
> Build an Extension From C Source
- bundle
> Unpacks a Pecl Package channel-add Add a Channel
- channel-alias
> Specify an alias to a channel name
- channel-delete
> Remove a Channel From the List
- channel-discover
> Initialize a Channel from its server
- channel-info
> Retrieve Information on a Channel
- channel-login
> Connects and authenticates to remote channel server
- channel-logout
> Logs out from the remote channel server
- channel-update
> Update an Existing Channel
- clear-cache
> Clear Web Services Cache
- config-create
> Create a Default configuration file
- config-get
> Show One Setting
- config-help
> Show Information About Setting
- config-set
> Change Setting
- config-show
> Show All Settings
- convert
> Convert a package.xml 1.0 to package.xml 2.0 format
- cvsdiff
> Run a "cvs diff" for all files in a package
- cvstag
> Set CVS Release Tag
- download
> Download Package
- download-all
> Downloads each available package from the default channel
- info
> Display information about a package
- install
> Install Package
- list
> List Installed Packages In The Default Channel
- list-all
> List All Packages
- list-channels
> List Available Channels
- list-files
> List Files In Installed Package
- list-upgrades
> List Available Upgrades
- login
> Connects and authenticates to remote server [Deprecated in - favor of channel-login]
- logout
> Logs out from the remote server [Deprecated in favor of channel-logout]
- make-rpm-spec
> Builds an RPM spec file from a PEAR package
- makerpm
> Builds an RPM spec file from a PEAR package
- package
> Build Package
- package-dependencies
> Show package dependencies
- package-validate
> Validate Package Consistency
- pickle
> Build PECL Package
- remote-info
> Information About Remote Packages
- remote-list
> List Remote Packages
- run-scripts
> Run Post-Install Scripts bundled with a package
- run-tests
> Run Regression Tests
- search
> Search remote package database
- shell-test
> Shell Script Test
- sign
> Sign a package distribution file
- svntag
> Set SVN Release Tag
- uninstall
> Un-install Package
- update-channels
> Update the Channel List
- upgrade
> Upgrade Package
- upgrade-all
> Upgrade All Packages [Deprecated in favor of calling upgrade with no parameters]
