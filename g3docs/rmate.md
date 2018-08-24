# rmate

If you wish to activate TextMate from an ssh session you can do so by copying the `rmate` (ruby) script to the server you are logged into. The script will connect back to TextMate running on your Mac so you should setup an ssh tunnel (as your Mac is likely behind NAT):

	ssh -R 52698:localhost:52698 user@example.org

or, if using unix sockets (available with OpenSSH v6.7 and above):

	ssh -R /home/user/.rmate.socket:localhost:52698 user@example.org

# Install

## Rubygems

You can install `rmate` via `gem`:

	gem install rmate

Updating to latest version can be done using:

	gem update rmate

## Standalone

Installing into `~/bin` can be done using these two lines:

	curl -Lo ~/bin/rmate https://raw.githubusercontent.com/textmate/rmate/master/bin/rmate
	chmod a+x ~/bin/rmate

If `~/bin` is not already in your `PATH` then you may want to add something like this to your shell startup file (e.g. `~/.profile`):

	export PATH="$PATH:$HOME/bin"

# Usage

	rmate [options] file

Call `rmate --help` for a list of options. Default options can be set in `/etc/rmate.rc` or `~/.rmate.rc`, e.g.:

	host: auto                   # Prefer host from SSH_CONNECTION over localhost
	port: 52698
	unixsocket: ~/.rmate.socket  # Use this socket file if it exists

You can also set the `RMATE_HOST`, `RMATE_PORT` and `RMATE_UNIXSOCKET` environment variables.

For more info see this [blog post about rmate](http://blog.macromates.com/2011/mate-and-rmate/ "TextMate Blog » mate and rmate").

# Ports

- [Bash](https://github.com/aurora/rmate) by Harald Lapp
- [Python](https://github.com/sclukey/rmate-python) by Steven Clukey
- [Perl](https://github.com/davidolrik/rmate-perl) by David Jack Wange Olrik

# Common Issues

* Port (tcp/udp) already in use: 
	- Use `ps aux | grep XXXX` where XXX is the port number to kill the process, or shift to a different port

* Rmate running issues when reverse tunnelling has been setup: 
```
/usr/bin/rmate:174:in `readline': end of file reached (EOFError)  from /usr/bin/rmate:174:in `connect_and_handle_cmds'  from /usr/bin/rmate:223:in `block in <main>'  from /usr/bin/rmate:222:in `fork'  from /usr/bin/rmate:222:in `<main>'
```
	- Ensure a textmate client on atom or vscode etc is listening to the port.

# Contribute to the Docs

Feel free to issue pull requests to the repo at `github.com/iitmcvg/workstation`