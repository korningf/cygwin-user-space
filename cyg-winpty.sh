# cyg-winpty.sh: install winpty.exe TTY master for consoles
# necessary to get mintty to work with docker and kubernetes 


git clone https://github.com/rprichard/winpty
cd winpty

./configure
make install

