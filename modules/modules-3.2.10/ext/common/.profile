# start .profile
if [ -f /etc/profile.modules ]; then
	. /etc/profile.modules
# put any common module loads here or in system .profile
#	module add null
fi

# user module loads
if [ -f $HOME/.modules ]; then
	. $HOME/.modules
fi

# PATH=$PATH:$HOME/bin; export PATH

# sh() { bash; }

# user environment
if [ -f $HOME/.profile.ext ]; then
	. $HOME/.profile.ext
fi

# end .profile
