package GMS::Lunch::Tools;
use utf8;
use strict;
use warnings;
use subs qw/getTime Today Yesterday Tomorrow getLunch getCache updateCache/;

use POSIX;
use YAML;
use Time::Piece;
use Time::Seconds;
use LWP::UserAgent;
use Web::Scraper;
use Data::Dumper;
use Encode qw/encode decode/;
require Exporter;

our @ISA = qw/Exporter/;
our @EXPORT = qw/getLunch Today Yesterday Tomorrow getCache updateCache/;

sub getLunch {
    my ($year, $month, $day) = @_;
    ($year, $month, $day) = Today unless ($year || $month || $day);
    my $lunch_url = 'http://gms.hs.kr/lunch.view?date='.$year.$month.$day;
    
    
    my $scraper = scraper {
        process '.menuBox .menuName span', 'lunch[]' => 'TEXT';    
    };
    
    my $ua = LWP::UserAgent->new(agent => 'Mozilla/5.0 (Linux) GMSLunchbot/1.0 Twitter/@GMSLunchbot');
    my $res = $scraper->scrape($ua->get($lunch_url)->decoded_content);
    
    my ($lunch, $dinner) = ($res->{lunch}->[0], $res->{lunch}->[1]);
    
    $lunch =~ s/[ ]+/,/g if $lunch;
    $dinner =~ s/[ ]+/,/g if $dinner;
    
    
    return {
        date => "$year/$month/$day",
        
        lunch => $lunch,
        dinner => $dinner,
    };
}

sub getTime {
    my $date = shift;
    $date = localtime unless $date;
    
    return ($date->strftime("%Y"), 
            $date->strftime("%m"), 
            $date->strftime("%d"));
}

sub Today {
    getTime;
}
sub Yesterday {
    getTime(localtime() - ONE_DAY);
}

sub Tomorrow {
    getTime(localtime() + ONE_DAY)
}


sub getCache {
    my ($year, $month, $day) = Today;
    
    open my $fh, '<', '/tmp/lunch.yaml' or return updateCache();
    my $lunch_data;
    while(<$fh>) {
        $lunch_data .= $_;
    }
    $lunch_data = YAML::Load( decode("utf-8", $lunch_data) );
    close $fh;
    
    return $lunch_data if ($lunch_data->{date} eq "$year/$month/$day");
    return updateCache();
}

sub updateCache {
    my $lunch_data = getLunch;
    
    open my $fh, '>', '/tmp/lunch.yaml' or die 'failed to open lunch.yaml';
    binmode $fh, ":encoding(utf8)";
    print $fh YAML::Dump( $lunch_data );
    close $fh;
    
    return $lunch_data;
}


1;
