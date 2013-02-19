#!/usr/bin/env perl
use strict;
use warnings;
use lib ('/home/cheesekun/dancerapps/GMS-Lunch/lib/'); #상위 폴더의 lib 폴더에서 모듈을 불러옵니다.
use utf8;
use GMS::Lunch::Tools;
use Net::Twitter;

my $consumer_key="kaZWoltau4zOJ163qU4Jw";
my $consumer_secret="rJtre7z0xLDZwJ3eiZqCubZSzMe77wiwoODtaq8jiF0";
my $access_token= "371382205-QIj7sIEob4678I1frleTFSTeOmG4BrpPWDwB6RKU";
my $access_token_secret ="RF9MK3NdlPqZqJLiuHyhvA0JY8O7b0mTMxyB0iJeZ0Y";

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
