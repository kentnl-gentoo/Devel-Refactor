#!/usr/bin/perl
use Data::Dumper;
use Devel::Refactor; 

$|++;

# Get the contents of the clipboard.  Requires dcop from KDE.
my $clipboard = `dcop klipper klipper getClipboardContents`;

print "Subroutine Name? ";
my $name = <STDIN>;

chomp $name;

my $refactory = Devel::Refactor->new($name, $clipboard, 1);

my $retval = $refactory->get_sub_call();
$retval .= $refactory->get_new_code();

# protect quotes and dollar signs
$retval =~ s/\"/\\"/g;
$retval =~ s/(\$)/\\$1/g;

#Put the results back on the clipboard.
`dcop klipper klipper setClipboardContents "$retval"`;
