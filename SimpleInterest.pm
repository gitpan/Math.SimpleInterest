##    Copyright (c) 2001 by Brad Yourth
##    All rights reserved.
##
##    This package is free software; you can redistribute it
##    and/or modify it under the same terms as Perl itself.

package Math::SimpleInterest;

use 5.006;
use strict;
use warnings;

require Exporter;
use Date::Calc qw/Date_to_Days Add_Delta_Days/;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	int_yrs
 	int_dates
	rate_yrs
 	rate_dates
 	principal_yrs
  	time_days
   	time_yrs
    time_date
  	fv_yrs
   	fv_dates
    pv_yrs
    pv_dates
);

our $VERSION = '0.04';

sub int_yrs {
	 $_[0] * $_[1] * $_[2] * 0.01;
}

sub int_dates {
	my $t = dates_to_yrs( $_[2],$_[3] );
	$_[0] * $_[1] * .01 * $t;
}

sub	rate_yrs {
	$_[1] / $_[0] / $_[2] * 100;
}

sub rate_dates {
	my $t = dates_to_yrs( $_[2],$_[3] );
	100 * $_[1] / $_[0] * $t;	
}

sub	principal_yrs {
	$_[0] / $_[1] / $_[2];
}

sub	time_days {
	365 * 100 * $_[1] / $_[0] / $_[2];
}

sub	time_yrs {
	100 * $_[1] / $_[0] / $_[2];
}

sub time_date {
	my $days = 365 * 100 * $_[1] / $_[0] / $_[2];
 	$_[3] =~ /(\d+)\/(\d+)\/(\d+)/;
 	join("/", Add_Delta_Days( $1,$2,$3,$days));
}
  	
sub fv_yrs {
	 $_[0] + $_[0] * $_[1] * $_[2] * 0.01;
}

sub fv_dates {
	my $t = dates_to_yrs( $_[2],$_[3] );
	$_[0] + $_[0] * $_[1] * .01 * $t;
}

sub pv_yrs {
	 $_[0] / ( 1 +  $_[1] * $_[2] * 0.01 );
}  
   	
sub pv_dates {
	my $t = dates_to_yrs( $_[2],$_[3] );
	$_[0] /( 1 + $_[1] * .01 * $t );
}

sub dates_to_yrs {
	$_[0] =~ /(\d{4})\/(\d+)\/(\d+)/;
 	my $d1 = Date_to_Days($1,$2,$3);
	$_[1] =~ /(\d{4})\/(\d+)\/(\d+)/; 
 	my $d2 = Date_to_Days($1,$2,$3);
	($d2 - $d1)/365;
} 
	
1;

__END__

=head1 NAME

	Math::SimpleInterest - Perl extension to Math:: for Simple Interest

=head1 PREFACE

	Math::SimpleInterest contains subroutines for simple interest
	calculations. Subroutines are provided for these formulas

	I = Prt		S = P(1 + rt)		P = S / (1 + rt)
	t = I/Pr	r = I/Pt		P = I/rt

	and include the use of calendar date strings thanks to 
	several subroutines from Steffen Bryer's Date::Calc
	module (which is required).

=head1 SYNOPSIS

	use Math::SimpleInterest;

=head1 FUNCTIONS

=head2 int_yrs

C<$interest = int_yrs( $prin, $rate, $years );>

Implements I = Prt where $years is in years.
Returns amount of interest. $rate is a percent, NOT a decimal.

=head2 int_dates

C<$interest = int_dates( $prin, $rate, "yyyy/mm/dd","yyyy/mm/dd" );>

For I = Prt given two date strings as shown. First date string is start date.
Returns interest earned. $rate is a percent, NOT a decimal.

=head2 rate_yrs

C<$rate = rate_yrs( $prin, $int, $years );>

Returns the annual interest rate as a percent, given $years in years.

=head2 rate_dates

C<$rate = rate_dates( $prin, $int, "yyyy/mm/dd","yyyy/mm/dd" );>

Returns rate % that yields $int interest on $prin between two dates.
First date string is start date.

=head2 principal_yrs

C<$prin = principal_yrs( $int, $rate, $years );>

For P = I/rt. $rate is a %, NOT a decimal. Returns principal needed.

=head2 time_days

C<$days = time_days( $int, $prin, $rate );>

Returns number of days needed for $prin to earn $int at $rate %.

=head2 time_yrs

C<$yrs = time_yrs( $prin, $int, $rate );>

Returns time in years needed for $prin to earn $int at $rate %.

=head2 time_date

C<$datestring = time_date( $prin, $int, $rate, "yyyy/mm/dd" );>

Returns date at which $prin will earn $int at $rate %. $datestring is in format "yyyy/mm/dd".

=head2 fv_yrs

C<$futurevalue = fv_yrs( $prin, $rate, $years );>

Implements S = P( 1 + rt ). $rate is a per cent. $years is in years.

=head2 fv_dates

C<$futurevalue = fv_dates( $prin, $rate, ""yyyy/mm/dd","yyyy/mm/dd" );>

Implements S = P( 1 + rt ) between two given dates. First date string is start date.

=head2 pv_yrs

C<$prin = pv_yrs( $futurevalue, $rate, $years );>

Implements P = S /( 1 + rt ) given $years in years. $rate is a per cent.

=head2 pv_dates

C<$prin = pv_dates( $futurevalue, $rate, ""yyyy/mm/dd","yyyy/mm/dd" );>

Implements P = S /( 1 + rt ) given two dates. First date is start date. $rate is a per cent.

=head2 dates_to_yrs

C<$yrs = dates_to_yrs( "yyyy/mm/dd","yyyy/mm/dd" );>

Computes number of years between two dates for some subs above. Intended primarily for internal use of other functions.

=head1 EXPORT

	None by default.

=head1 AUTHOR

	Brad Yourth

I<yourthb@spjc.edu>

=head1 SEE ALSO

	Date::Calc for Date_to_Days and Add_Delta_Days functions

=head1 DISCLAIMER

This package is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut
