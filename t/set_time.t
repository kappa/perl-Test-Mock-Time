use 5.010001;
use warnings;
use strict;
use utf8;
use Test::More;
use Test::Exception;

BEGIN { use_ok('Test::Mock::Time', qw/set_time ff/); }

my $t = time;

cmp_ok $t, '>', 1455000000, 'time looks like current actual time';

ok(set_time(517440180), 'set_time returns ok');    # Chernobyl

$t = time;
is $t, 517440180, 'set_time did set time';

my $ct = CORE::time();
select undef,undef,undef,1.1;
cmp_ok CORE::time(), '>', $ct, 'CORE::time() is increased';

is time, $t, 'time is same after real 1.1 second delay';

sleep 0;
is time, $t, 'time is same after sleep 0';
sleep 1;
is time, $t+=1, 'time is increased by 1';

ff(1000);
is time, $t+=1000, 'time is increased by 1000 after ff(1000)';

ok(set_time, 'set_time w/o arguments');
cmp_ok time, '>', 1455000000, 'set_time may reset to current actual time';

done_testing();
