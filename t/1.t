# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { use_ok('Devel::Refactor') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $snippet ='
	$code = "Test code";
	my @inside_array = ();
	@test_array = keys %test_hash;
	
	foreach my $test (@test_array){
	    print "$test \t $code\n";
	    $test_hash{$test}++;
	}
	my $code2 = "More Test stuff\n";
';

my $sub_name = 'test_sub';

open LOG,">test.log" or die "Can't open test.log: $!\n";
print LOG "Starting Values:\n";
print LOG "$sub_name\n";
print LOG $snippet;
print LOG "*************************************************\n";

my $refactory = Devel::Refactor->new($sub_name, $snippet, 1);

ok(defined($refactory), 'Create Object');
ok(1, 'Check sub call');
ok(1, 'Check sub creation');

print LOG "Transformed Values:\n";
print LOG $refactory->get_sub_call();
print LOG $refactory->get_new_code();

print LOG "Non-Local Scalars: ";
print LOG map {"$_ "} $refactory->get_scalars();
print LOG "\n";
print LOG "Non-Local Arrays: ";
print LOG map {"$_ "} $refactory->get_arrays();
print LOG "\n";
print LOG "Non-Local Hashes: ";
print LOG map {"$_ "} $refactory->get_hashes();
print LOG "\n";
print LOG "Local Scalars: ";
print LOG map {"$_ "} $refactory->get_local_scalars();
print LOG "\n";
print LOG "Local Arrays: ";
print LOG map {"$_ "} $refactory->get_local_arrays();
print LOG "\n";
print LOG "Local Hashes: ";
print LOG map {"$_ "} $refactory->get_local_hashes();
print LOG "\n";
