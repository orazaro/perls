#!/usr/bin/perl -w
use strict;

package LogServer;

use base qw(Net::Server::HTTP);
__PACKAGE__->run(port=>8888);

sub process_http_request {
  my $self = shift;

  print "Content-type: text/html\n\n";
  print "<form method=post action=/bam><input type=text name=foo><input type=submit></form>\n";

  if (require Data::Dumper) {
     local $Data::Dumper::Sortkeys = 1;
     my $form = {};
     if (require CGI) {  my $q = CGI->new; $form->{$_} = $q->param($_) for $q->param;  }
     print "<pre>".Data::Dumper->Dump([\%ENV, $form], ['*ENV', 'form'])."</pre>";
  }

# log environment
  open(my $fh, '>>', "/usr2/ban_sys/httpd/cgi-bin/logenv.log") or die $!;
  print $fh "=====================================================\n";
  print $fh "LOGSERVER: date: ",scalar localtime(time),"\n";
  print $fh "=====================================================\n";
  foreach my $key (keys(%ENV)) {
    	print $fh $key,"=",$ENV{$key},"<br>\n"
  }
  print $fh "=====================================================\n";
  close $fh;

}
