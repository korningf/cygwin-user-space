#  module:  ssh.profile                 ssh profile configurator
#  project: manufacture cygwin          cygwin.manufacture.net      
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html

# ssh agent
SSH_AGENT=/usr/bin/ssh-agent
SSH_AGENT_ARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSH_AGENT" ]; then
  eval `$SSH_AGENT $SSH_AGENT_ARGS`
  trap "kill $SSH_AGENT_PID" 0
fi

