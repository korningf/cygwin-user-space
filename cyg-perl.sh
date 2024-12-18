#  module:  cyg-perl.sh                 cygwin perl configurator
#  project: manufacture cygwin          cygwin.manufacture.net     
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


# cyg-perl-cpan cpan perl library manager


echo installing perl CPAN-minus CPAN-plus

cpan -i Perl6::Say

cpan -i App::cpanminus

cpanp -i CPANPLUS::Backend

