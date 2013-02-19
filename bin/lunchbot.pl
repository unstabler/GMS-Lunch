#!/usr/bin/env perl
use utf8;
use strict;
use warnings;

use FindBin qw/$Bin/;
use lib ("$Bin/../lib/"); #상위 폴더의 lib 폴더에서 모듈을 불러옵니다.
use GMS::Lunch::Tools;
use GMS::Lunch::Config;
use Net::Twitter;


my $twitter = Net::Twitter->new(
    legacy_lists_api    => 0,
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $access_token,
    access_token_secret => $access_token_secret
);

my $lunch = getCache;
my ($year, $month, $day) = Today;

my $random_zerowidth = (int(rand(100)));

exit unless ($lunch->{lunch});

my $string = sprintf("%d년 %d월 %d일 급식은 %s 이며, 석식은 %s 입니다.%s", $year, $month, $day, $lunch->{lunch}, $lunch->{dinner}, $random_zerowidth) if ($lunch->{dinner});
$string = sprintf("%d년 %d월 %d일 급식은 %s 입니다.%s", $year, $month, $day, $lunch->{lunch}, $random_zerowidth);

eval {$twitter->update($string)};
warn $@ if $@;
