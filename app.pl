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
    my $plaintext = "Error : URI vacía";
    my $encrypted = RC4($key, $plaintext);
    my $encoded = encode_base64($encrypted);
    my $decoded = decode_base64($encoded);
    my $decrypted = RC4($key, $decoded);
    
    $self->render(text => $decrypted);
};

post '/encode' => sub {
    my $self = shift;
    #inicio hook CORS
    $self->res->headers->header('Access-Control-Allow-Origin' => '*');
    $self->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
	#fin hook CORS
    my $key = $self->req->param('key');
    my $texto = $self->req->param('texto');
    my $encrypted = RC4($key, $texto);
    my $encoded = encode_base64($encrypted);
    
    $self->render(text => $encoded);
};

post '/decode' => sub {
    my $self = shift;
    #inicio hook CORS
    $self->res->headers->header('Access-Control-Allow-Origin' => '*');
    $self->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
	#fin hook CORS
    my $key = $self->req->param('key');
    my $texto = $self->req->param('texto');
    my $decoded = decode_base64($texto);
    my $decrypted = RC4($key, $decoded);
    
    $self->render(text => $decrypted);
};

get '/key' => sub {
    my $self = shift;
    #inicio hook CORS
    $self->res->headers->header('Access-Control-Allow-Origin' => '*');
    $self->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
	#fin hook CORS
    my @chars = ('0'..'9', 'A'..'Z', 'a'..'z');
    my $len = 16;
    my $key;
    while($len--){ $key .= $chars[rand @chars] };
    
    $self->render(text => $key);
};

app->start;