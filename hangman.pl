#!/usr/bin/perl -w
use strict;

my ($miss, $guesses, $guess, @build, $tries, @guessed, @wordbank);

sub get_random_word{
	my @wordbank = @_;
	my $selected = rand(scalar(@wordbank));
	return split(//, $wordbank[$selected]);
}

@wordbank = qw(cubicle scramble deduction envelope century ridiculous);
my @word = get_random_word(@wordbank);

@build = ("_") x scalar(@word);

$_ = join('', @word);
$miss = 0;
$guesses = 0;
$tries = 0;

print "Welcome to hangman\n";
print "Your word has "; print scalar(@word); print " guesses";


