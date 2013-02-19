package GMS::Lunch;
use strict;
use warnings;
use Encode qw/encode decode/;
use GMS::Lunch::Tools;

use Dancer ':syntax';


our $VERSION = '0.1';

get '/' => sub {
    my $lunch = getCache;
    template 'index';
};

get '/api' => sub {
    
};

get '/api/yesterday' => sub {
    to_json(getLunch(Yesterday));
};

get '/api/tomorrow' => sub {
    to_json(getLunch(Tomorrow));
};


get '/api/today' => sub {
    to_json(getCache);
};

true;
