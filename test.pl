# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Math::SimpleInterest;
ok(1); # If we made it this far, we're ok.

#########################

print int_yrs(100,1,1),"\n";
printf( "\$%.2f\n", int_dates( 100,10,"2001/01/01","2002/01/01"));
printf( "\$%.2f\n", fv_yrs( 100,10,1));
printf( "\$%.2f\n", fv_dates( 100,10,"2001/01/01","2002/01/01"));
printf( "\$%.2f\n", pv_yrs( 110,10,1));
printf( "\$%.2f\n", pv_dates( 110,10,"2001/01/01","2002/01/01"));
printf( "%.2f%%\n", rate_yrs( 100,10,1));
printf( "%.2f%%\n", rate_dates( 100,10,"2001/01/01","2002/01/01"));
printf( "\$%.2f\n", fv_yrs( 100,10,1));
printf( "%.0f\n", time_days( 100,10,10));
printf( "%.2f\n", time_yrs( 100,10,10));
print time_date( 100,10,10,"2001/01/01" );