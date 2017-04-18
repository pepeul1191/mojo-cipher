#!/usr/bin/env perl
use Mojolicious::Lite;
use Crypt::RC4;
use MIME::Base64;

get '/' => sub {
    my $self = shift;
    #inicio hook CORS
    $self->res->headers->header('Access-Control-Allow-Origin' => '*');
    $self->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
	#fin hook CORS
    
    my $key       = "abcdefghijklm";
    my $plaintext = "Hello, World!";
    my $encrypted = RC4($key, $plaintext);

    my $encoded = encode_base64($encrypted);
    my $decoded = decode_base64($encoded);
    my $decrypted = RC4($key, $decoded);
    
    $self->render(text => $decrypted);
};

app->start;