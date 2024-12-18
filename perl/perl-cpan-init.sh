mkdir -p /usr/lib/perl5/site_perl

cpan -i App::cpanminus
cpan -i CPANPLUS:i:Backend

cpanp -i CPANPLUS:i:Backend
